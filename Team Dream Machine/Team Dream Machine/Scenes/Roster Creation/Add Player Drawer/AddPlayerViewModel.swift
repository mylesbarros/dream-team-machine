//
//  AddPlayerViewModel.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 27.02.2022.
//

import Combine
import Foundation

protocol PlayerCreationDelegate: AnyObject {
    func newPlayerCreated(name: String)
    func userRequestedToClosePlayerCreation()
}

final class AddPlayerViewModel: ObservableObject {

    @Published var newPlayerName: String = ""

    private weak var creationDelegate: PlayerCreationDelegate?

    init(delegate: PlayerCreationDelegate) {
        creationDelegate = delegate
    }

    func userDidTapToAddPlayer() {
        creationDelegate?.newPlayerCreated(name: newPlayerName)
    }

    func userDidTapToClose() {
        creationDelegate?.userRequestedToClosePlayerCreation()
    }
}
