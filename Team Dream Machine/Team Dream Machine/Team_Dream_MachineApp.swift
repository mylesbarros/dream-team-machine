//
//  Team_Dream_MachineApp.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 26.02.2022.
//

import SwiftUI
import TeamResolver

@main
struct Team_Dream_MachineApp: App {
    var body: some Scene {
        WindowGroup {
            RosterList()
        }
    }
    
    func ignoreMe() -> some View {
        testXanthesCode()
        
        return Text("You're doing a great job!")
    }
    
    // MARK: - Xanthe's Code Dumpster
    
    func testXanthesCode() {
        let emptyTeam = Team()
        
        let builder = TeamBuilder()
        builder.buildTeam(2, testCombos, emptyTeam)
    }
}
