//
//  PlayerInterestConverter.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 02.03.2022.
//

import Foundation

struct PairInterestConverter {

    func convert(_ interest: PairingInterestLevel) -> Float {
        switch interest {
        case .😬: return 2.0
        case .🙂: return 4.0
        case .😃: return 6.0
        case .😍: return 8.0
        }
    }
}
