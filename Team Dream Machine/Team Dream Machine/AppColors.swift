//
//  AppColors.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 01.03.2022.
//

import SwiftUI

extension Color {

    // Welcome Scene
    enum Welcome {
        static let sky = Color("SkyBlue")
    }

    // Roster List
    enum Roster {
        static let rosterGradientTop = Color(hex: "E4EFE1")
        static let rosterGradientBottom = Color(hex: "CCD5FF")

        static let bottomDrawer = Color.blue
    }

    // Pass the Phone Scene
    enum NewUser {
        static let instructions = Color(hex: "232b2b")
        static let newUserName = Color("HotPink")

        static let gradientTop = Color(hex: "C3B1E1")
        static let gradientBottom: Color = Color(hex: "DCFFFB")
    }

    // Feedback Input Scene
    enum Feedback {
        static let topText = Color(hex: "581F18")
        static let nameText = Color(hex: "#E06C9F")

        static let gradientTop = Color(hex: "F6F5AE")
        static let gradientBottom = Color(hex: "FFD1BA")
    }

    // Final Results Scene
    enum TeamResults {
        static let gradientTop = Color(hex: "F6F5AE")
        static let gradientBottom = Color(hex: "FFD1BA")
    }
}
