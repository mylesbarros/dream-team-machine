//
//  PlayerIntersectionCoordinatorViewModel.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 14.03.2022.
//

import SwiftUI

protocol RosterProvider: AnyObject {
    var people: [Person] { get }
}

final class PlayerPairingCoordinatorViewModel: ObservableObject {

    // MARK: - Public Properties

    @Published var playerGivingFeedback: Person?
    @Published var doesPlayerHaveThePhone: Bool = false
    @Published var doneGatheringFeedback: Bool = false

    private(set) var pairings: [PlayerPairing] = []

    private(set) var isFirstUser: Bool = true

    var potentialTeammates: [Person] {
        var teammates = playerPairBuilder.allPlayers
        teammates.removeAll(where: { $0 == playerGivingFeedback })

        return teammates
    }

    // MARK: - Private Properties

    private let rosterProvider: RosterProvider
    private lazy var playerPairBuilder: PlayerPairBuilder = {
        return PlayerPairBuilder(playersToPair: rosterProvider.people)
    }()

    // MARK: - Initializers

    init(rosterProviding: RosterProvider) {
        rosterProvider = rosterProviding
    }

    // MARK: - Scene Lifecycle

    func sceneIsActive() {
        guard let firstPlayerToPair = playerPairBuilder.dequeNextPlayerToPair() else {
            fatalError("Roster is empty, we have no players to pair.")
        }

        playerGivingFeedback = firstPlayerToPair
    }
}

// MARK: - Protocol Extensions

// MARK: PlayerPairingNavigationDelegate
extension PlayerPairingCoordinatorViewModel: PlayerPairingNavigationDelegate {
    func playerDidConfirmReceiptOfPhone() {
        withAnimation { doesPlayerHaveThePhone = true }
    }
}

// MARK: FeedbackDelegate
extension PlayerPairingCoordinatorViewModel: FeedbackDelegate {
    func userDidProvide(feedback: [PlayerPairing]) {
        pairings.append(contentsOf: feedback)
        isFirstUser = false

        guard let nextPlayer = playerPairBuilder.dequeNextPlayerToPair() else {
            doneGatheringFeedback = true
            return
        }

        withAnimation {
            playerGivingFeedback = nextPlayer
            doesPlayerHaveThePhone = false
        }
    }
}
