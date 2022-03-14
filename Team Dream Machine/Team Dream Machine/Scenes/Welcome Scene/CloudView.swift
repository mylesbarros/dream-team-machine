//
//  Cloud.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 02.03.2022.
//

import SwiftUI

enum CloudType: Int, CaseIterable {
    case bubbly = 1
    case flowingRight = 2
    case driftingLeft = 3
    case smokey = 4
    case flowingLeft = 5

    static var random: CloudType {
        let index: Int = .random(in: 0..<Self.allCases.count)
        return Self.allCases[index]
    }
}

enum CloudPosition: CaseIterable {
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

    var body: some View {
        GeometryReader { geometry in
            Image("Cloud\(type.rawValue)")
                .resizable()
                .scaledToFit()
                .frame(width: 102 * sizeScaling, height: 37.5 * sizeScaling, alignment: .trailing)
                .offset(x: horizontalOffset, y: verticalOffset)
                .onAnimationCompleted(for: horizontalOffset, completion: {
                    let newVertical: Float = .random(in: -60...60)
                    verticalOffset = CGFloat(newVertical)

                    if horizontalOffset > 0 {
                        horizontalOffset = .random(in: -230 ... -(102 * sizeScaling))
                    }
                    withAnimation(driftAnimation, {
                        horizontalOffset = geometry.size.width + (103 * sizeScaling)
                    })
                })
                .onAppear(perform: {
                    withAnimation(driftAnimation, {
                        horizontalOffset = geometry.size.width + (103 * sizeScaling)
                    })
                })
        }
    }

    // MARK: - Private Properties

    @State private var horizontalOffset: CGFloat
    @State private var verticalOffset: CGFloat = 0

    private let type: CloudType
    private let position: CloudPosition

    private let driftAnimation: Animation
    private let sizeScaling: CGFloat

    // MARK: - Initializers

    init(type: CloudType, position: CloudPosition, verticalOffset: CGFloat = 0, screenWidth: CGFloat, hardcodedStartingX: CGFloat? = nil) {
        self.type = type
        self.position = position
        if let hardcodedStartingX = hardcodedStartingX {
            horizontalOffset = hardcodedStartingX
        } else {
            horizontalOffset = .random(in: -200...(screenWidth - 140))
        }
        self.verticalOffset = verticalOffset

        let animationScaling: CGFloat
        switch position {
        case .backgroundFurther:
            animationScaling = 2.2
            sizeScaling = 0.5
        case .backgroundCloser:
            animationScaling = 1.8
            sizeScaling = 0.8
        case .foregroundFurther:
            animationScaling = 1.4
            sizeScaling = 1
        case .foregroundCloser:
            animationScaling = 1
            sizeScaling = 1.25
        }

        let jitter: Double = .random(in: -0.5...8)

        driftAnimation = Animation.linear(
            duration: (11 + jitter) * animationScaling
        ).repeatForever(autoreverses: false)
    }
}
