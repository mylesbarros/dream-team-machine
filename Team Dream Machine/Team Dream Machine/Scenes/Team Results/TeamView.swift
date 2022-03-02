//
//  TeamView.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 01.03.2022.
//

import SwiftUI

struct TeamView: View {
    var body: some View {
        List {
            ForEach(viewModel.teamMembers) { playerName in
                Text(playerName.name)
            }
        }
    }

    private let viewModel: TeamViewModel

    init(teamMembers: [Person]) {
        viewModel = .init(teamMembers: teamMembers)
    }
}

struct TeamViewModel {

    let teamMembers: [Person]

    init(teamMembers: [Person]) {
        self.teamMembers = teamMembers
    }
}
