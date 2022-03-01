//
//  PairingSceneLinkFactory.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 01.03.2022.
//

import SwiftUI

struct PairingSceneLinkFactory {

    @State private var isActive: Bool = true

    @ViewBuilder
    func make(shouldGoToPairingScene: Bool, rosterProvider: RosterListViewModel) -> some View {
        switch shouldGoToPairingScene {
        case false:
            EmptyView()
        case true:
            EmptyView()
//            NavigationLink(
//            destination: PlayerPairingCoordinator(roster: rosterProvider.people),
//            isActive: $isActive) { EmptyView() }
        }
    }

}
