//
//  User.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let profilePictureURL: URL
    let stories: [URL] = [
        URL(string: "https://picsum.photos/id/\(Int.random(in: 1...1000))/500"),
        URL(string: "https://picsum.photos/id/\(Int.random(in: 1...1000))/500"),
        URL(string: "https://picsum.photos/id/\(Int.random(in: 1...1000))/500")
    ].compactMap(\.self)

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
