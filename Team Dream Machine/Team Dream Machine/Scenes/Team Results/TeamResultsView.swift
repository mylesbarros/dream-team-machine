//
//  TeamResults.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 01.03.2022.
//

import SwiftUI

struct TeamResultsView: View {

    // MARK: - Public Properties

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.secondTeamPlayers.isEmpty {
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
            .background(LinearGradient(
                gradient: Gradient(colors: [
                    .TeamResults.gradientTop,
                    .TeamResults.gradientBottom
                ]),
                startPoint: .top,
                endPoint: .bottom
            ))
            .navigationTitle("✨ Dream Teams ✨")
            .onAppear(perform: {
                viewModel.processResults()
            })
        }
    }

    // MARK: - Private Properties

    @ObservedObject private var viewModel: TeamResultsViewModel

    // MARK: - Initializers

    init(playerPreferences: [PlayerPairing]) {
        UITableView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Color.TeamResults.title]
        viewModel = .init(playerPreferences: playerPreferences)
    }
}
