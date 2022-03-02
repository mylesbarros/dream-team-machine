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
                .frame(width: screenWidth, height: 48, alignment: .center)
            Text(viewModel.isFirstUser ? "Let's get started!" : "You're done!")
                .foregroundColor(.textPrimary)
                .font(.title2)
            Spacer()
                .frame(width: screenWidth, height: 16, alignment: .center)
            Text("Please pass the phone to")
                .foregroundColor(.textPrimary)
                .font(.title3)
            Spacer()
                .frame(width: screenWidth, height: 8, alignment: .center)
            HStack {
                Text("✨ ")
                    .font(.largeTitle)
                Text("\(viewModel.intendedUser.name)")
                    .font(.largeTitle)
                    .foregroundColor(.textName)
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
        .background(Color.background)
    }

    // MARK: - Private Properties

    private var viewModel: PassThePhoneViewModel

    private var screenWidth: CGFloat { Device.screen.width }

    // MARK: - Initializers

    init(nextPlayerGivingFeedback: Person,
         isFirstUser: Bool,
         navigationDelegate: PlayerPairingNavigationDelegate
    ) {
        self.viewModel = .init(
            intendedUser: nextPlayerGivingFeedback,
            isFirstUser: isFirstUser,
            delegate: navigationDelegate
        )
    }
}
