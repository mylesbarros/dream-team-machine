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
    var body: some View {
        ZStack {
            if !didAppear { EmptyView() }
            else {
                if !viewModel.doesPlayerHaveThePhone {
                    PassThePhoneView(
                        nextPlayerGivingFeedback: viewModel.playerGivingFeedback!,
                        navigationDelegate: viewModel
                    )
                } else {
                    TeammateFeedbackView(
                        getFeedbackFor: viewModel.potentialTeammates,
                        from: viewModel.playerGivingFeedback!,
                        delegate: viewModel
                    ).transition(.backslide)
                }
            }
        }
        .onAppear(perform: {
            viewModel.sceneIsActive()
            self.didAppear = true
        })
    }

    @ObservedObject var viewModel: PlayerPairingCoordinatorViewModel

    @State private var didAppear: Bool = false

    init(rosterProvider: RosterProvider) {
        viewModel = .init(rosterProviding: rosterProvider)
    }
}

protocol PlayerPairingDelegate: AnyObject {

}

protocol RosterProvider: AnyObject {
    var people: [Person] { get }
}

final class PlayerPairingCoordinatorViewModel: ObservableObject {

    @Published var playerGivingFeedback: Person?
    @Published var doesPlayerHaveThePhone: Bool = false

    var potentialTeammates: [Person] {
        var teammates = playerPairBuilder.allPlayers
        teammates.removeAll(where: { $0 == playerGivingFeedback })

        return teammates
    }

    private let rosterProvider: RosterProvider
    private lazy var playerPairBuilder: PlayerPairBuilder = {
        return PlayerPairBuilder(playersToPair: rosterProvider.people)
    }()

    init(rosterProviding: RosterProvider) {
        rosterProvider = rosterProviding
    }

    func sceneIsActive() {
        guard let firstPlayerToPair = playerPairBuilder.dequeNextPlayerToPair() else {
            fatalError("Roster is empty, we have no players to pair.")
        }

        playerGivingFeedback = firstPlayerToPair
    }

}

extension PlayerPairingCoordinatorViewModel: PlayerPairingNavigationDelegate {
    func playerDidConfirmReceiptOfPhone() {
        withAnimation { doesPlayerHaveThePhone = true }
    }
}

extension PlayerPairingCoordinatorViewModel: FeedbackDelegate {
    func userDidProvide(feedback: [PlayerPairing]) {
        guard let nextPlayer = playerPairBuilder.dequeNextPlayerToPair() else {
            // We're done pairing!
            return
        }

        withAnimation {
            playerGivingFeedback = nextPlayer
            doesPlayerHaveThePhone = false
        }
    }
}

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading)
        )
    }
}
