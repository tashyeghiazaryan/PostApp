//
//  Presenter.swift
//  PostApp
//
//  Created by Artashes Yeghiazaryan on 25.11.2024.
//

import Foundation
import Combine

class PostPresenter: ObservableObject {
    private let interactor: PostInteractor
    
    @Published var posts: [Post] = []
    @Published var currentUser: User
    
    init(interactor: PostInteractor) {
        self.interactor = interactor
        self.currentUser = interactor.users.first!
        self.posts = interactor.posts
    }
    
    func switchUser(to user: User) {
        currentUser = user
    }
    
    func addPost(text: String, image: String?) {
        interactor.addPost(user: currentUser, text: text, image: image)
        posts = interactor.posts
    }
    
    var users: [User] {
        interactor.users
    }
    
    func toggleLike(for post: Post) {
        if let index = posts.firstIndex(where: { $0.id == post.id }) {
            posts[index].isLiked.toggle()
            posts[index].likeCount += posts[index].isLiked ? 1 : -1
        }
    }
}
