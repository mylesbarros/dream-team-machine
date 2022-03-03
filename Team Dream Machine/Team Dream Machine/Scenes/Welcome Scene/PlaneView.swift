//
//  PlaneView.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 03.03.2022.
//

import SwiftUI

struct PlaneView: View {

    var body: some View {
        Image("Plane")
            .resizable()
            .frame(width: 100, height: 100, alignment: .trailing)
            .ignoresSafeArea()
            .offset(x: viewModel.isFlying ? -300 : screenWidth, y: -134)
    }

    private var screenWidth: CGFloat

    @ObservedObject private var viewModel: PlaneViewModel = .init()

    init(screenWidth: CGFloat) {
        self.screenWidth = screenWidth
    }
}

final class PlaneViewModel: ObservableObject {

    @Published var isFlying: Bool = false

    private let flyingAnimation = Animation.linear(duration: 24)

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5, execute: {
            withAnimation(self.flyingAnimation, { self.isFlying = true })
        })
    }
}
