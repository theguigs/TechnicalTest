//
//  UserService.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

import SwiftUI
import Combine

class UserService {
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
}
