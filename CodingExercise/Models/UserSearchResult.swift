//
//  UserSearchResult.swift
//  CodingExercise
//
//  Copyright © 2018 slack. All rights reserved.
//

import Foundation

struct UserSearchResult: Codable {
    let avatarUrlStr: String
    let displayName: String
    let username: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case username
        case displayName = "display_name"
        case id
        case avatarUrlStr = "avatar_url"
    }
}

struct SearchResponse: Codable {
    let ok: Bool
    let error: String?
    let users: [UserSearchResult]
}
