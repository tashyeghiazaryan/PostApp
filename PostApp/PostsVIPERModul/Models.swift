//
//  Models.swift
//  PostApp
//
//  Created by Artashes Yeghiazaryan on 25.11.2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let name: String
    let username: String
    let profileImage: String
}

struct Post: Identifiable, Codable {
    var id = UUID()
    let user: User
    let text: String
    let imagePath: String?
    let timestamp: Date
    var commentCount: Int
    var watchCount: Int
    var likeCount: Int
    var shareCount: Int
    var isLiked: Bool = false
}
