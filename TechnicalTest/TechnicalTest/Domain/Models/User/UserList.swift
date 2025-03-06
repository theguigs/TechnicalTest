//
//  UserList.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

struct UserList: Codable {
    let pages: [UserPage]
}

struct UserPage: Codable {
    let users: [User]
}
