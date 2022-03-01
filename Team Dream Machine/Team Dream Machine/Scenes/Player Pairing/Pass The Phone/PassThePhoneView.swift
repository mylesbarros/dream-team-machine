//
//  PassThePhoneView.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 27.02.2022.
//

import SwiftUI

struct PassThePhoneView: View {

    // MARK: - Public Properties

    var body: some View {
        VStack {
            Spacer()
                .frame(width: screenWidth, height: 16, alignment: .center)
            Text("Thanks!")
                .font(.title2)
            Spacer()
                .frame(width: screenWidth, height: 16, alignment: .center)
            Text("Please pass the phone to")
                .font(.title3)
            Spacer()
                .frame(width: screenWidth, height: 8, alignment: .center)
            HStack {
                Text("✨ ")
                    .font(.largeTitle)
                Text("\(viewModel.intendedUser.name)")
                    .font(.largeTitle)
                    .id("AnimatedActiveUser-\(viewModel.intendedUser.name)")
                    .rainbowAnimation()
                Text(" ✨")
                    .font(.largeTitle)
            }
            Spacer()
            Button(
                action: { viewModel.userHasConfirmedReceipt() },
                label: {
                    Text("I'm \(viewModel.intendedUser.name)!")
                        .font(.title2)
                }
            ).frame(maxWidth: screenWidth, alignment: .bottom)
            Spacer()
                .frame(width: screenWidth, height: 32, alignment: .center)
        }
    }

    // MARK: - Private Properties

    private var viewModel: PassThePhoneViewModel

    private var screenWidth: CGFloat { Device.screen.width }

    // MARK: - Initializers

    init(nextPlayerGivingFeedback: Person, navigationDelegate: PlayerPairingNavigationDelegate) {
        self.viewModel = .init(
            intendedUser: nextPlayerGivingFeedback,
            delegate: navigationDelegate
        )
    }
}
