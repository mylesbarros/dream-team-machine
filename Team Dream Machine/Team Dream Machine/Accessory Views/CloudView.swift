//
//  Cloud.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 02.03.2022.
//

import SwiftUI

enum CloudType: Int {
    case bubbly = 1
    case flowingRight = 2
    case driftingLeft = 3
    case smokey = 4
    case flowingLeft = 5
}

enum CloudPosition {
    case foregroundCloser
    case foregroundFurther
    case backgroundCloser
    case backgroundFurther
}

enum DriftDirection {
    case toLeadingEdge, toTrailingEdge
}

struct CloudView: View {

    // MARK: - Public Properties

    let type: CloudType
    let position: CloudPosition
    @State var verticalOffset: CGFloat

    var body: some View {
        GeometryReader { geometry in
            Image("Cloud\(type.rawValue)")
                .resizable()
                .scaledToFit()
                .frame(width: 102 * sizeScaling, height: 37.5 * sizeScaling, alignment: .trailing)
                .offset(
                    x: horizontalOffset,
                    y: verticalOffset
                )
                .onAnimationCompleted(for: horizontalOffset, completion: {
                    let randomRange: Int = .random(in: 0...15)
                    let randomAdjustment: Double = Double(randomRange) * 0.1
                    let verticalUpdate: CGFloat = verticalOffset * CGFloat(randomAdjustment)
                    verticalOffset = verticalUpdate

                    if horizontalOffset > 102 {
                        horizontalOffset = -102
                    }
                    withAnimation(driftAnimation, {
                        horizontalOffset = geometry.size.width + 102
                    })
                })
                .onAppear(perform: {
                    withAnimation(driftAnimation, {
                        horizontalOffset = geometry.size.width + 102
                    })
                })
        }
    }

    // MARK: - Private Properties

    @State private var horizontalOffset: CGFloat = -102

    private let driftAnimation: Animation
    private let sizeScaling: CGFloat

    init(type: CloudType, position: CloudPosition, verticalOffset: CGFloat) {
        self.type = type
        self.position = position
        self.verticalOffset = verticalOffset

        let animationScaling: CGFloat
        switch position {
        case .backgroundFurther:
            animationScaling = 2
            sizeScaling = 0.5
        case .backgroundCloser:
            animationScaling = 1.2
            sizeScaling = 0.8
        case .foregroundFurther:
            animationScaling = 1
            sizeScaling = 1
        case .foregroundCloser:
            animationScaling = 0.75
            sizeScaling = 1.25
        }

        let jitter: Double = .random(in: -2...5)

        driftAnimation = Animation.linear(
            duration: (11 + jitter) * animationScaling
        ).repeatForever(autoreverses: false)
    }
}
