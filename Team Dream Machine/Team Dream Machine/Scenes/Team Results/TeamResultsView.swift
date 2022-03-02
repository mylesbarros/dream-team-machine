//
//  TeamResults.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 01.03.2022.
//

import SwiftUI

struct TeamResultsView: View {
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Form {
                        Section("First Team") {
                            TeamView(teamMembers: viewModel.firstTeamPlayers)
                        }
                        Section("Second Team") {
                            TeamView(teamMembers: viewModel.secondTeamPlayers)
                        }
                    }
                }
            }
            .background(Color.background)
            .navigationTitle("✨ Dream Teams ✨")
        }
    }

    @ObservedObject private var viewModel: TeamResultsViewModel

    init(playerPreferences: [PlayerPairing]) {
        UITableView.appearance().backgroundColor = .clear
        viewModel = .init(playerPreferences: playerPreferences)
    }
}

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
