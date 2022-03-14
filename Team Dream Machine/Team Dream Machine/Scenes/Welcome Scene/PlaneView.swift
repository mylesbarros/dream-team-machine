//
//  PlaneView.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 03.03.2022.
//

import SwiftUI

struct PlaneView: View {

    // MARK: - Public Properties

    var body: some View {
        Image("Plane")
            .resizable()
            .frame(width: 100, height: 100, alignment: .trailing)
            .ignoresSafeArea()
            .offset(x: viewModel.isFlying ? -300 : screenWidth, y: -134)
    }

    // MARK: - Private Properties

    private var screenWidth: CGFloat

    @ObservedObject private var viewModel: PlaneViewModel = .init()

    // MARK: - Initializers

    init(screenWidth: CGFloat) {
        self.screenWidth = screenWidth
    }
}

final class PlaneViewModel: ObservableObject {

    // MARK: - Public Properties

    @Published var isFlying: Bool = false

    // MARK: - Private Properties

    private let flyingAnimation = Animation.linear(duration: 24)

    // MARK: - Initializers

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5, execute: {
            withAnimation(self.flyingAnimation, { self.isFlying = true })
        })
    }
}
