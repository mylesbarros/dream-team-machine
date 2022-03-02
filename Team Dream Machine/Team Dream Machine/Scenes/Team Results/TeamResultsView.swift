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
