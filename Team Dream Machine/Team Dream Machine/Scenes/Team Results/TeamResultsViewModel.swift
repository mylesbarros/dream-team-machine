//
//  TeamResultsViewModel.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 02.03.2022.
//

import Combine
import Foundation

final class TeamResultsViewModel: ObservableObject {

    // MARK: - Public Properties

    @Published var isLoading: Bool = true
    @Published var firstTeamPlayers: [Person] = []
    @Published var secondTeamPlayers: [Person] = []

    // MARK: - Private Properties

    private let playerPreferences: [PlayerPairing]
    private let pairInterestConverter: PairInterestConverter = .init()

    // MARK: - Initializers

    init(playerPreferences: [PlayerPairing]) {
        self.playerPreferences = playerPreferences

        // TODO: XANTHE
        // You should call the framework here.
        // The combos to send are available in playerPreferences.
        // You should save the results into firstTeamPlayers and secondTeamPlayers
        // You can delete this existing code at the bottom but you will need to set
        // isLoading to false once your data is loaded.
        //
        // The `PlayerPairing` contains a `.pairingInterest` property that expresses
        // the pair weight. To convert this to a Float call...
        // let floatWeight = pairInterestConverter.convert(playerPairing.pairingInterest)
        //
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            self.isLoading = false
        })
    }
}
