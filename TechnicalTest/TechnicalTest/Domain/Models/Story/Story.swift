//
//  Story.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

import Foundation

struct Story: Codable, Identifiable {
    let id: String
    let url: URL
}

extension Story: Equatable {
    static func == (lhs: Story, rhs: Story) -> Bool {
        return lhs.id == rhs.id
    }
}
