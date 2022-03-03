//
//  PlayerImageFactory.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 02.03.2022.
//

import SwiftUI

struct PlayerImageFactory {

    func imageName(forPlayer playerName: String) -> String {
        let simplifiedName = playerName.lowercased()

        if simplifiedName.contains("kaja") {
            return "Caroline"
        }
        else if simplifiedName.contains("myles") {
            return "Myles"
        }
        else if simplifiedName.contains("xanthe") {
            return "Xanthe"
        }
        else if simplifiedName.contains("nora") {
            return "Nora"
        }
        else if simplifiedName.contains("adam") {
            return "Adam"
        }
        else if simplifiedName.contains("anicka") || simplifiedName.contains("anička") {
            return "Anicka"
        }
        else if simplifiedName.contains("honza") ||
                    simplifiedName.contains("jan") {
            return "Honza"
        }
        else if simplifiedName.contains("danda") ||
                    simplifiedName.contains("daniela") {
            return "Danya"
        }
        else if simplifiedName.contains("loran") {
            return "Loran"
        }
        else {
            return "Unidentified"
        }
    }

}
