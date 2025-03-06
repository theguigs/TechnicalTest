//
//  StoryService.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

import Foundation

class StoryService {
    private(set) var likedStoryIDs: Set<String>
    private let likedStoryIDsStorageKey = "likedStoryIDs"

    init() {        
        if let likedStoryIDs = UserDefaults.standard.array(forKey: self.likedStoryIDsStorageKey) as? [String] {
            self.likedStoryIDs = Set(likedStoryIDs)
        } else {
            self.likedStoryIDs = []
        }
    }

    // MARK: - Like / Unlike stories

    func likeStory(storyID: String) {
        self.likedStoryIDs.insert(storyID)
        self.saveLikedStories()
    }

    func unlikeStory(storyID: String) {
        self.likedStoryIDs.remove(storyID)
        self.saveLikedStories()
    }

    func storyIsLiked(storyID: String) -> Bool {
        return likedStoryIDs.contains(storyID)
    }
}

private extension StoryService {
    func saveLikedStories() {
        let stringIDs = likedStoryIDs.map { $0 }
        UserDefaults.standard.set(stringIDs, forKey: self.likedStoryIDsStorageKey)
    }
}
