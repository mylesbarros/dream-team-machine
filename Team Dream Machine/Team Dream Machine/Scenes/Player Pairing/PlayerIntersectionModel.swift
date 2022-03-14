//
//  PlayerIntersectionModel.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 27.02.2022.
//

import Foundation

struct PlayerIntersectionModel {

    let player: Person
    let potentialTeamates: [Person]

}

enum PairingInterestLevel: String, CaseIterable {
    case 😬
    case 🙂
    case 😃
    case 😍
}

struct PlayerPairing {

    let player: Person
    let potentialTeammate: Person
    let pairingInterest: PairingInterestLevel

}

final class PlayerPairBuilder {

    // MARK: - Public Properties

    let allPlayers: [Person]
    private(set) var playerPairings: [Person: [PlayerPairing]] = [:]

    // MARK: - Private Properties

    private var unpairedPlayers: [Person]

    // MARK: - Initializers

    init(playersToPair: [Person]) {
        unpairedPlayers = playersToPair
        allPlayers = playersToPair
    }

    // MARK: - Unpaired Players

    func dequeNextPlayerToPair() -> Person? {
        guard !unpairedPlayers.isEmpty else { return nil }

        return unpairedPlayers.removeLast()
    }

    // MARK: - Paired Players

    func registerPairing(of player: Person, with potentialTeamate: Person, interestLevel: PairingInterestLevel) {
        if playerPairings[player] == nil {
            playerPairings[player] = []
        }

        playerPairings[player]?.append(PlayerPairing(
            player: player,
            potentialTeammate: potentialTeamate,
            pairingInterest: interestLevel
        ))
    }

}
