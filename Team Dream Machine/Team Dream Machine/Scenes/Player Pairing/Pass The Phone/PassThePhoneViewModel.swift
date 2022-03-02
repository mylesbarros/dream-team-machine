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
    let isFirstUser: Bool

    // MARK: - Private Properties

    private weak var delegate: PlayerPairingNavigationDelegate?

    // MARK: - Initializers

    init(intendedUser: Person, isFirstUser: Bool, delegate: PlayerPairingNavigationDelegate) {
        self.intendedUser = intendedUser
        self.isFirstUser = isFirstUser
        self.delegate = delegate
    }

    // MARK: - User Events

    func userHasConfirmedReceipt() {
        delegate?.playerDidConfirmReceiptOfPhone()
    }
}
