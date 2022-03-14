//
//  PlayerPairingCoordinator.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 01.03.2022.
//

import SwiftUI

protocol PlayerPairingNavigationDelegate: AnyObject {
    func playerDidConfirmReceiptOfPhone()
}

struct PlayerPairingCoordinator: View {

    // MARK: - Public Properties

    var body: some View {
        ZStack {
            if !didAppear { EmptyView() }
            else {
                if !viewModel.doesPlayerHaveThePhone {
                    PassThePhoneView(
                        nextPlayerGivingFeedback: viewModel.playerGivingFeedback!,
                        isFirstUser: viewModel.isFirstUser,
                        navigationDelegate: viewModel
                    )
                } else {
                    TeammateFeedbackView(
                        getFeedbackFor: viewModel.potentialTeammates,
                        from: viewModel.playerGivingFeedback!,
                        delegate: viewModel
                    )
                }
            }
        }
        .background(Color.clear)
        .transition(.backslide)
        .onAppear(perform: {
            viewModel.sceneIsActive()
            self.didAppear = true
        })
        .fullScreenCover(
            isPresented: $viewModel.doneGatheringFeedback,
            content: { TeamResultsView(playerPreferences: viewModel.pairings) }
        )
    }

    @ObservedObject var viewModel: PlayerPairingCoordinatorViewModel

    // MARK: - Private Properties

    @State private var didAppear: Bool = false

    private var screenHeight: CGFloat { Device.screen.height }

    // MARK: - Initializers

    init(rosterProvider: RosterProvider) {
        viewModel = .init(rosterProviding: rosterProvider)
    }
}
