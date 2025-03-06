//
//  ProgressViewBar.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

import SwiftUI

struct ProgressViewBar: View {
    let progress: CGFloat

    var body: some View {
        ZStack(alignment: .leading) {
            Capsule()
                .foregroundColor(Color.gray.opacity(0.5))

            Capsule()
                .frame(maxWidth: self.progressBarWidth)
                .foregroundColor(.white)
                .animation(.linear, value: self.progress)
        }
        .frame(height: 4)
        .frame(maxWidth: .infinity)
    }

    private var progressBarWidth: CGFloat {
        self.progress * UIScreen.main.bounds.width
    }
}
