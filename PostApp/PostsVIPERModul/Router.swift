//
//  Router.swift
//  PostApp
//
//  Created by Artashes Yeghiazaryan on 25.11.2024.
//

import SwiftUI

class PostRouter {
    static func createPostPage() -> some View {
        let interactor = PostInteractor()
        let presenter = PostPresenter(interactor: interactor)
        return PostListView(presenter: presenter)
    }
}
