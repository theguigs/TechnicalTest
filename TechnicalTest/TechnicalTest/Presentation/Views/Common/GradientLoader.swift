//
//  GradientLoader.swift
//  TechnicalTest
//
//  Created by Guillaume Audinet on 06/03/2025.
//

import SwiftUI

struct GradientLoader: View {
    @State private var isAnimating = false

    var body: some View {
        Circle()
            .trim(from: 0.0, to: 0.8)
            .stroke(
                AngularGradient(
                    gradient: Gradient(colors: [.blue, .purple, .pink]),
                    center: .center
                ),
                style: StrokeStyle(lineWidth: 3, lineCap: .round)
            )
            .frame(width: 25, height: 25)
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .animation(
                Animation.linear(duration: 1)
                    .repeatForever(autoreverses: false),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}
