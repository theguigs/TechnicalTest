//
//  UserListViewModel.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

import SwiftUI
import Combine

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var storySeen: [User] = []

    @Published var isLoading: Bool = false

    private var userService: UserService = .init()

    private var nextPage: Int = 0
    private var hasMoreContent: Bool = true
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.loadMoreUsers()
    }
    
    func loadMoreUsers() {
        guard self.hasMoreContent else { return } // Should only continue only API has more content to send
        guard !self.isLoading else { return }
        
        self.isLoading = true
        
        self.userService.fetchUsers(for: self.nextPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error): break // TODO : Gestion erreur
                default: break
                }
                
                self?.isLoading = false
            } receiveValue: { [weak self] newUsers in
                if newUsers.isEmpty {
                    self?.hasMoreContent = false
                }
                
                self?.users.append(contentsOf: newUsers)
                self?.nextPage += 1
            }
            .store(in: &self.cancellables)
    }
    
    func userDidTapped(_ user: User) {
        guard !self.storySeen.contains(user) else { return }
        self.storySeen.append(user)
    }
    
    func storySeen(for user: User) -> Bool {
        self.storySeen.contains(user)
    }
}
