//
//  StoryViewModel.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

import Foundation

class StoryViewModel: ObservableObject {
    var user: User
    @Published var likedStoryIDs: Set<String>
    
    private let storyService = StoryService()
    
    init(user: User) {
        self.user = user
        self.likedStoryIDs = self.storyService.likedStoryIDs
    }

    func isLiked(storyID: Int) -> Bool {
        let consolidatedStoryID = "\(self.user.id)_\(storyID)"
        
        return self.storyService.storyIsLiked(storyID: consolidatedStoryID)
    }
    
    func likeOrUnlike(storyID: Int) {
        let consolidatedStoryID = "\(self.user.id)_\(storyID)"
        
        if self.storyService.storyIsLiked(storyID: consolidatedStoryID) {
            self.storyService.unlikeStory(storyID: consolidatedStoryID)
        } else {
            self.storyService.likeStory(storyID: consolidatedStoryID)
        }
        
        self.likedStoryIDs = self.storyService.likedStoryIDs
    }
}
