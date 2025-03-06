//
//  StoryViewModel.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

import Foundation

class StoryViewModel: ObservableObject {
    init(user: User) {
        self.user = user
    }
    
    var user: User
}
