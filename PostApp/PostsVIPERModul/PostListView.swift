//
//  PostListView.swift
//  PostApp
//
//  Created by Artashes Yeghiazaryan on 25.11.2024.
//

import SwiftUI

struct PostListView: View {
    @ObservedObject var presenter: PostPresenter
    @State private var isCreatingPost = false
    @State private var selection = 1
    @State private var scaledPostID: UUID?
    @State private var filteredPosts: [Post] = []
    @State private var showShareSheet = false
    @State private var shareContent: [Any] = []
    @State private var sharePostID: UUID?

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                // Main List
                List(filteredPosts, id: \.id) { post in
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Image(systemName: post.user.profileImage)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())

                            VStack(alignment: .leading) {
                                Text(post.user.name).bold()
                                Text(post.user.username).font(.subheadline).foregroundColor(.gray)
                            }
                        }

                        Text(post.text)

                        // Post Image
                        if let imagePath = post.imagePath {
                            if UIImage(systemName: imagePath) != nil {
                                Image(systemName: imagePath)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 200)
                            } else if let uiImage = UIImage(contentsOfFile: imagePath) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 200)
                            }
                        }

                        // Action Buttons
                        HStack {
                            // Comment Button
                            Button(action: { print("Comment on post: \(post.id)") }) {
                                HStack { Text("💬"); Text("\(post.commentCount)") }
                            }
                            Spacer()
                            
                            // Watch Button
                            Button(action: { print("Watch post: \(post.id)") }) {
                                HStack { Text("👀"); Text("\(post.watchCount)") }
                            }
                            Spacer()
                            
                            // Like Button with Animation
                            Button(action: {
                                presenter.toggleLike(for: post)
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0)) {
                                    scaledPostID = post.id
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    scaledPostID = nil
                                }
                            }) {
                                HStack {
                                    Text(post.isLiked ? "❤️" : "🤍")
                                    Text("\(post.likeCount)")
                                }
                                .scaleEffect(scaledPostID == post.id ? 1.3 : 1.0) // Scale animation
                            }
                            .foregroundColor(post.isLiked ? .red : .blue)
                            Spacer()
                            
                            // Share Button
                            Button(action: {
                                sharePostID = post.id
                                shareContent = createShareContent(for: post)
                                showShareSheet = true
                            }) {
                                HStack { Text("🔄"); Text("\(post.shareCount)") }
                            }
                            .sheet(isPresented: Binding(
                                get: { sharePostID == post.id && showShareSheet },
                                set: { if !$0 { showShareSheet = false } }
                            )) {
                                ShareSheet(items: shareContent)
                            }
                        }
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .padding(.top, 5)
                    }
                    .padding(.vertical, 10)
                }

                // Floating Create Post Button
                Button(action: {
                    isCreatingPost = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .padding(.trailing, 26)
                .padding(.bottom, 16)
            }
            .sheet(isPresented: $isCreatingPost) {
                CreatePostView(presenter: presenter, isPresented: $isCreatingPost)
            }
            .customNavigation
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    BaseNavigationBar(selection: $selection)
                        .onChange(of: selection) { newSelection in
                            applyFilter(for: newSelection)
                            print("Loaded Posts: \(presenter.posts.map { "Likes: \($0.likeCount), Watches: \($0.watchCount)" })")
                        }
                }
            }
        }
        .onAppear {
            applyFilter(for: selection)
        }
    }

    // Filter function based on selection
    private func applyFilter(for selection: Int) {
        switch selection {
        case 0:
            // Show only the current user's posts
            filteredPosts = presenter.posts.filter { $0.user.id == presenter.currentUser.id }
        case 1:
            // Show all posts
            filteredPosts = presenter.posts
        default:
            filteredPosts = presenter.posts
        }
    }
    
    private func createShareContent(for post: Post) -> [Any] {
        var content: [Any] = [post.text]
        
        if let imagePath = post.imagePath, let uiImage = UIImage(contentsOfFile: imagePath) {
            content.append(uiImage)
        }
        
        return content
    }
}
