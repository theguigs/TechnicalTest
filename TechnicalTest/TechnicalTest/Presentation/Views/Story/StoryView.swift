//
//  StoryView.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

import SwiftUI

struct StoryView: View {
    @StateObject var viewModel: StoryViewModel
    @Binding var isPresented: Bool
    
    @State private var currentStoryIndex = 0

    var body: some View {
        ZStack {
            if let url = self.viewModel.user.stories[safe: self.currentStoryIndex] {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    GradientLoader()
                }
            } else {
                EmptyView()
            }
            
            HStack {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.moveToPreviousStory()
                    }

                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        self.moveToNextStory()
                    }
            }
            .onTapGesture(count: 2) {
                self.viewModel.likeOrUnlike(storyID: self.currentStoryIndex)
            }

            VStack {
                HStack(spacing: 4) {
                    ForEach(self.viewModel.user.stories.indices, id: \.self) { index in
                        ProgressViewBar(progress: self.progress(for: index))
                    }
                }
                .frame(height: 4)
                .padding(.horizontal)

                HStack {
                    AsyncImage(url: self.viewModel.user.profilePictureURL) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        GradientLoader()
                    }
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())
                    
                    Text(self.viewModel.user.name)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Button(action: {
                        self.isPresented = false
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding(8)
                    }
                }
                .padding(8)
                Spacer()
                Button(action: {
                    self.viewModel.likeOrUnlike(storyID: self.currentStoryIndex)
                }) {
                    Image(systemName: self.viewModel.isLiked(storyID: currentStoryIndex) ? "heart.fill" : "heart")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding(8)
                }

            }
        }
    }
    
    private func progress(for index: Int) -> CGFloat {
        if index <= self.currentStoryIndex { return 1 }
        else if index > self.currentStoryIndex { return 0 }
        
        // TODO: Evolve to manage dynamic progression
        return 0
    }
    
    private func moveToPreviousStory() {
        guard self.currentStoryIndex > 0 else { return }
        
        self.currentStoryIndex -= 1
    }

    private func moveToNextStory() {
        guard self.currentStoryIndex < self.viewModel.user.stories.count - 1 else {
            self.isPresented = false
            return
        }
        
        self.currentStoryIndex += 1
    }
}
