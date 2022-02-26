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
            ignoreMe()
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
        let result = builder.buildTeam(4, testCombos, testCombos.count, team: emptyTeam)
        
        print("\nResults!")
        print("Total Score: \(result.score)")
        print("Say hi to your new team!")
        result.newTeam.roster.forEach({ playerName in
            print(playerName)
        })
    }
}
