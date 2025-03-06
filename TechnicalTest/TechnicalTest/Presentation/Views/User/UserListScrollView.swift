//
//  UserListScrollView.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

import SwiftUI

struct UserListScrollView: View {
    @StateObject private var viewModel = UserListViewModel()
    
    @State private var selectedUser: User? = nil

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(self.viewModel.users) { user in
                    UserView(user: user, showGradient: !self.viewModel.userSeen(for: user))
                        .onAppear {
                            if user == self.viewModel.users.last {
                                self.viewModel.loadMoreUsers()
                            }
                        }
                        .onTapGesture {
                            self.viewModel.userDidTapped(user)
                            self.selectedUser = user
                        }
                        .fullScreenCover(item: $selectedUser) { user in
                            StoryView(
                                viewModel: .init(user: user),
                                isPresented: Binding(
                                    get: { selectedUser != nil },
                                    set: { isPresented in
                                        if !isPresented { selectedUser = nil }
                                    }
                                )
                            )
                        }
                }
                
                if self.viewModel.isLoading {
                    GradientLoader()
                        .padding()
                }
            }
            .padding()
        }
    }
}
