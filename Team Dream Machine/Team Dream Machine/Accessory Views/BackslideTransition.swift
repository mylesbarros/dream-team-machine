//
//  BackslideTransition.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 14.03.2022.
//

import SwiftUI

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading)
        )
    }
}
