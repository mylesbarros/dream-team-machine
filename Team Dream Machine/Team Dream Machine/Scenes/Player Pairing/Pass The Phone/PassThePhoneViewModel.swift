//
//  PassThePhoneViewModel.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 01.03.2022.
//

import Combine
import Foundation

final class PassThePhoneViewModel: ObservableObject {

    // MARK: - Public Properties

    let intendedUser: Person

    // MARK: - Private Properties

    private weak var delegate: PlayerPairingNavigationDelegate?

    // MARK: - Initializers

    init(intendedUser: Person, delegate: PlayerPairingNavigationDelegate) {
        self.intendedUser = intendedUser
        self.delegate = delegate
    }

    // MARK: - User Events

    func userHasConfirmedReceipt() {
        delegate?.playerDidConfirmReceiptOfPhone()
    }
}
