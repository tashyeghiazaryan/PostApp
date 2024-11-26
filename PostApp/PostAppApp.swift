//
//  PostAppApp.swift
//  PostApp
//
//  Created by Artashes Yeghiazaryan on 25.11.2024.
//

import SwiftUI

@main
struct PostAppApp: App {
    var body: some Scene {
        WindowGroup {
            PostRouter
                .createPostPage()
                .preferredColorScheme(.dark)
        }
    }
}
