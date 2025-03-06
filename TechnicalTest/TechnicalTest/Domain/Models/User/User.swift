//
//  User.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let profilePictureURL: URL

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePictureURL = "profile_picture_url"
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
