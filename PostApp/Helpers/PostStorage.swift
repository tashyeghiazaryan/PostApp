//
//  PostStorage.swift
//  PostApp
//
//  Created by Artashes Yeghiazaryan on 26.11.2024.
//

import Foundation

class PostStorage {
    private let postsKey = "SavedPosts"

    func savePosts(_ posts: [Post]) {
        do {
            let data = try JSONEncoder().encode(posts)
            UserDefaults.standard.set(data, forKey: postsKey)
        } catch {
            print("Failed to save posts: \(error)")
        }
    }

    func loadPosts() -> [Post] {
        guard let data = UserDefaults.standard.data(forKey: postsKey) else { return [] }
        do {
            return try JSONDecoder().decode([Post].self, from: data)
        } catch {
            print("Failed to load posts: \(error)")
            return []
        }
    }
}
