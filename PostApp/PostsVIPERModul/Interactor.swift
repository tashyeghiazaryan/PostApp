//
//  PostInteractor.swift
//  PostApp
//
//  Created by Artashes Yeghiazaryan on 25.11.2024.
//

import Foundation

class PostInteractor {
    // MARK: - Properties
    private(set) var posts: [Post]
    private let storage = PostStorage()
    let users: [User]
    private let firstLaunchKey = "FirstLaunchFlag"

    // MARK: - Initialization
    init(users: [User]? = nil, posts: [Post]? = nil) {
        self.users = users ?? [
            User(id: UUID(), name: "Sheryl", username: "@smata", profileImage: "person"),
            User(id: UUID(), name: "Jackie", username: "@jbowerson", profileImage: "person.circle"),
            User(id: UUID(), name: "Alex", username: "@alex123", profileImage: "person.crop.circle")
        ]
        
        self.posts = posts ?? [
            Post(
                id: UUID(),
                user: self.users[0],
                text: "Okay #Apple... I need your help! I’m still less than a year into investing but haven’t been able to find a mentor… suggestions?",
                imagePath: nil,
                timestamp: Date(),
                commentCount: Int.random(in: 0...100),
                watchCount: Int.random(in: 100...1000),
                likeCount: Int.random(in: 50...500),
                shareCount: Int.random(in: 0...50)
            ),
            Post(
                id: UUID(),
                user: self.users[1],
                text: "While I listen to #TSLA’s announcements (yes, again)... I thought back to this news I captured last night...",
                imagePath: "house.fill",
                timestamp: Date(),
                commentCount: Int.random(in: 0...100),
                watchCount: Int.random(in: 100...1000),
                likeCount: Int.random(in: 50...500),
                shareCount: Int.random(in: 0...50)
            ),
            Post(
                id: UUID(),
                user: self.users[2],
                text: "Excited to share my first investment strategy! Let me know what you think.",
                imagePath: "chart.bar.fill",
                timestamp: Date(),
                commentCount: Int.random(in: 0...100),
                watchCount: Int.random(in: 100...1000),
                likeCount: Int.random(in: 50...500),
                shareCount: Int.random(in: 0...50)
            )
        ]
    }

    // MARK: - Methods
    
    func addPost(user: User, text: String, image: String?) {
        let post = Post(
            id: UUID(),
            user: user,
            text: text,
            imagePath: image,
            timestamp: Date(),
            commentCount: 0,
            watchCount: 0,
            likeCount: 0,
            shareCount: 0
        )
        posts.insert(post, at: 0)
        savePosts()
    }
    
    private func savePosts() {
        storage.savePosts(posts)
    }
    
    /// Fetch all posts
    func fetchPosts() -> [Post] {
        return posts
    }
    
    /// Fetch posts for a specific user (optional feature)
    func fetchPosts(for user: User) -> [Post] {
        return posts.filter { $0.user.id == user.id }
    }
}
