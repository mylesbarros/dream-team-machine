//
//  TeamResultsViewModel.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 02.03.2022.
//

import Combine
import Foundation
import TeamResolver

final class TeamResultsViewModel: ObservableObject {

    // MARK: - Public Properties

    @Published var firstTeamPlayers: [Person] = []
    @Published var secondTeamPlayers: [Person] = []

    // MARK: - Private Properties

    private let playerPreferences: [PlayerPairing]

    // MARK: - Initializers

    init(playerPreferences: [PlayerPairing]) {
        self.playerPreferences = playerPreferences
    }
    
    func processResults() {
        let teamBuilder = TeamBuilder()
        
        DispatchQueue.global(qos: .userInitiated).async {
            let combos: [Combo] = self.playerPreferences.map({ Combo(pair: $0) })
            let teamResults = teamBuilder.buildTeam(combos)
            
            DispatchQueue.main.async {
                self.firstTeamPlayers = teamResults.team1.roster.map({ .init(name: $0) })
                self.secondTeamPlayers = teamResults.team2.roster.map({ .init(name: $0) })
            }
        }
    }
}

// MARK: - Convenience Extensions (Map App -> Package types)

extension TeamResolver.Person {
    init(person: Person) {
        self.init(name: person.name)
    }
}

extension TeamResolver.Combo {
    init(pair: PlayerPairing) {
        let pairInterestConverter: PairInterestConverter = .init()
        self.init(
            person1: TeamResolver.Person(person: pair.player),
            person2: TeamResolver.Person(person: pair.potentialTeammate),
            score: pairInterestConverter.convert(pair.pairingInterest)
        )
    }
}
