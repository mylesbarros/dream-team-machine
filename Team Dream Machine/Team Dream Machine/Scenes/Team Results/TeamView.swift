//
//  TeamView.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 01.03.2022.
//

import SwiftUI

struct TeamView: View {

    // MARK: - Public Properties

    var body: some View {
        List {
            ForEach(viewModel.teamMembers) { playerName in
                Text(playerName.name)
            }
        }
    }

    // MARK: - Private Properties

    private let viewModel: TeamViewModel

    // MARK: - Initializers

    init(teamMembers: [Person]) {
        viewModel = .init(teamMembers: teamMembers)
    }
}

struct TeamViewModel {

    // MARK: - Public Properties

    let teamMembers: [Person]

    // MARK: - Initializers

    init(teamMembers: [Person]) {
        self.teamMembers = teamMembers
    }
}
