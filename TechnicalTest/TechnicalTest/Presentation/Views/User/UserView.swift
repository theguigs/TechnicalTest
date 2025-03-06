//
//  UserView.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

import SwiftUI

struct UserView: View {
    let user: User
    let showGradient: Bool

    var body: some View {
        ZStack {
            VStack {
                AsyncImage(url: self.user.profilePictureURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    GradientLoader()
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding(4)
                .overlay {
                    Circle()
                        .stroke(
                            LinearGradient(
                                colors: [.blue, .purple, .pink],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 4
                        )
                        .opacity(self.showGradient ? 1 : 0)
                        .animation(.easeInOut, value: self.showGradient)
                }

                Text(self.user.name)
                    .font(.system(size: 14))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(width: 120)
        }
    }
}

#Preview {
    UserView(
        user: .init(
            id: 0,
            name: "Guillaume",
            profilePictureURL: URL(string: "https://i.pravatar.cc/300?u=1") ?? URL(fileURLWithPath: "")
        ),
        showGradient: true
    )
}
