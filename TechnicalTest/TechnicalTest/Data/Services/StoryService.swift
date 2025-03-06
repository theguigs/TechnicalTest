//
//  StoryService.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

import Foundation

class StoryService {
    private(set) var likedStoryIDs: Set<String>
    private let storageKey = "likedStoryIDs"

    init() {
        if let savedData = UserDefaults.standard.array(forKey: self.storageKey) as? [String] {
            self.likedStoryIDs = Set(savedData)
        } else {
            self.likedStoryIDs = []
        }
    }

    func likeStory(storyID: String) {
        self.likedStoryIDs.insert(storyID)
        self.saveToUserDefaults()
    }

    func unlikeStory(storyID: String) {
        self.likedStoryIDs.remove(storyID)
        self.saveToUserDefaults()
    }

    func storyIsLiked(storyID: String) -> Bool {
        return likedStoryIDs.contains(storyID)
    }

    private func saveToUserDefaults() {
        let stringIDs = likedStoryIDs.map { $0 }
        UserDefaults.standard.set(stringIDs, forKey: self.storageKey)
    }
}
