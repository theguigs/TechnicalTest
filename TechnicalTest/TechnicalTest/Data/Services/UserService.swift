//
//  UserService.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

import SwiftUI
import Combine

class UserService {
    private(set) var seenUserIDs: Set<String>
    private let seenUserIDsStorageKey = "seenUserIDs"

    init() {
        if let seenStoryIDs = UserDefaults.standard.array(forKey: self.seenUserIDsStorageKey) as? [String] {
            self.seenUserIDs = Set(seenStoryIDs)
        } else {
            self.seenUserIDs = []
        }
    }

    func fetchUsers(for page: Int) -> AnyPublisher<[User], Error> {
        return Just(self.loadUsersFromFile(for: page))
            .delay(for: .seconds(1), scheduler: RunLoop.main) // Use to simulate a false delay API call
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
        
    func loadUsersFromFile(for page: Int) -> [User] {
        guard let url = Bundle.main.url(forResource: "users", withExtension: "json") else {
            print("❌ [loadUsersFromFile] File not fount: users.json")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let list = try JSONDecoder().decode(UserList.self, from: data)
            return list.pages[safe: page]?.users ?? []
        } catch {
            print("❌ [loadUsersFromFile] \(error.localizedDescription)")
            return []
        }
    }
    
    // MARK: - Seen / Unseen stories
    
    func seeUser(userID: String) {
        self.seenUserIDs.insert(userID)
        self.saveSeenStories()
    }

    func unseeUser(userID: String) {
        self.seenUserIDs.remove(userID)
        self.saveSeenStories()
    }

    func storyIsSeen(userID: String) -> Bool {
        return seenUserIDs.contains(userID)
    }
}

private extension UserService {
    func saveSeenStories() {
        let stringIDs = seenUserIDs.map { $0 }
        UserDefaults.standard.set(stringIDs, forKey: self.seenUserIDsStorageKey)
    }
}
