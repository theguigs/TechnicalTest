//
//  UserListScrollView.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

import SwiftUI

struct UserListScrollView: View {
    @StateObject private var viewModel = UserListViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(self.viewModel.users) { user in
                    UserView(user: user, showGradient: !self.viewModel.storySeen(for: user))
                        .onAppear {
                            if user == self.viewModel.users.last {
                                self.viewModel.loadMoreUsers()
                            }
                        }
                        .onTapGesture {
                            self.viewModel.userDidTapped(user)
                        }
                }
            }
            .padding()
        }
    }
}
