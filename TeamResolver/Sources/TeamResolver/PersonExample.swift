//
//  File.swift
//  
//
//  Created by Xanthe Hammer on 2/26/22.
//

import Foundation

public struct Person {
    let id: Int
    let name: String
}

public struct Combo {
    let person1: Person
    let person2: Person
    let score: Int
}

public struct TeamResult {
    public let newTeam: Team
    public let score: Int
}

public final class TeamBuilder {
    
    public init() {}
    
    public func buildTeam(_ numPeople: Int, _ combos: [Combo], _ n: Int, team: Team) -> TeamResult {
        
        let scores: [Int] = combos.map({ combo in combo.score })
        
        // Base Case
        if n == 0 || numPeople == 0 {
            return TeamResult(newTeam: team, score: 0)
        }
        
        // Update the team with the new pair of team members.
        let currPair = combos[n-1]
        var updatedTeam = Team(team)
        updatedTeam.add(pair: currPair)
        
        if 2 > numPeople {
            return buildTeam(numPeople, combos, n-1, team: updatedTeam)
        }
        else {
            // First Choice: We include this pair in our team. Welcome!
            let firstOption = buildTeam(numPeople - 2, combos, n-1, team: updatedTeam)
            
            // Second Option: We skip this pair and exclude it from the team. Piss off.
            let secondOption = buildTeam(numPeople, combos, n-1, team: team)
            
            // Update the score with the contribution of the new pairing.
            let newPairScoreContribution = scores[n-1]
            let firstOptionScore = newPairScoreContribution + firstOption.score
            
            // If we skip this pair, the score does not change.
            let secondOptionScore = secondOption.score
            
            print("-- Input --")
            print("Person 1: \(currPair.person1.name). Person 2: \(currPair.person2.name). FOS: \(firstOptionScore). SOS: \(secondOptionScore).")
            
            // Which score is better?
            if firstOptionScore >= secondOptionScore {
                print("Added!")
                return TeamResult(
                    newTeam: firstOption.newTeam,
                    score: firstOptionScore
                )
            } else {
                return TeamResult(
                    newTeam: secondOption.newTeam,
                    score: secondOptionScore
                )
            }
        }
    }
    
}

public struct Team {
    
    public var roster: [String] { Array(people) }
    
    private var people: Set<String> = .init()
    
    public init(_ existingTeam: Team? = nil) {
        if let existingTeam = existingTeam {
            existingTeam.roster.forEach({ playerName in
                people.insert(playerName)
            })
        }
    }
    
    mutating func add(pair: Combo) {
        people.insert(pair.person1.name)
        people.insert(pair.person2.name)
    }
    
}

let myles = Person(id: 0, name: "Myles")
let kaja = Person(id: 1, name: "Kaja")
let nora = Person(id: 2, name: "Nora")
let xanthe = Person(id: 3, name: "Xanthe")
let adam = Person(id: 0, name: "Adam")

public let testCombos = [
    Combo(person1: myles, person2: kaja, score: -1),
    Combo(person1: myles, person2: nora, score: 0),
    Combo(person1: myles, person2: xanthe, score: 2),
    Combo(person1: myles, person2: adam, score: 1),
    
    Combo(person1: kaja, person2: nora, score: 1),
    Combo(person1: kaja, person2: xanthe, score: 0),
    Combo(person1: kaja, person2: adam, score: 0),
    
    Combo(person1: nora, person2: xanthe, score: 3),
    Combo(person1: nora, person2: adam, score: -1),
    
    Combo(person1: xanthe, person2: adam, score: -1),
]

