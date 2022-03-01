//
//  File.swift
//  
//
//  Created by Xanthe Hammer on 2/26/22.
//

import Foundation

public struct Person: Hashable {
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
    
    func sumTeam(team: [Combo]) -> Int{
        var sum = 0
        for combo in team{
            sum += combo.score
        }
        return sum
    }
    
    public func buildTeam(_ numTeams: Int, _ combos: [Combo], _ team: Team) {
        
        //TODO: Average player intersections to account for differing opinions
        var combos: [Combo] = combos
        
        combos.sort(by: { lhs, rhs in
            lhs.score > rhs.score
        })

        var team1Scores : [Combo] = []
        var team2Scores : [Combo] = []
        
        var team1Roster = Team()
        var team2Roster = Team()
        
        var evaluatedPlayers: [Person] = []
        for i in 0..<combos.count{
            var combo = combos[i]
            
            let comboPlayerWasAlreadyChecked = evaluatedPlayers.contains(where: { alreadyEvaluatedPerson in
                combo.person1 == alreadyEvaluatedPerson ||
                combo.person2 == alreadyEvaluatedPerson
            })
            
            guard !comboPlayerWasAlreadyChecked else { continue }
            
            let sum1 = sumTeam(team: team1Scores)
            let sum2 = sumTeam(team: team2Scores)
            if (sum1 <= sum2){
                team1Scores.append(combo)
                team1Roster.add(pair: combo)
            }
            else{
                team2Scores.append(combo)
                team2Roster.add(pair: combo)
            }
            
            evaluatedPlayers.append(contentsOf: [combo.person1, combo.person2])
        }
        
        let comboPeople: [Person] = combos.flatMap({ [$0.person1, $0.person2] })
        let allPlayers : Set<Person> = Set(comboPeople)
        
        var unevaluatedPlayers = allPlayers
        unevaluatedPlayers.subtract(evaluatedPlayers)
        assert(unevaluatedPlayers.count <= 1)
        if let unevaluatedPlayer = unevaluatedPlayers.first {
            //Account for uneven numbers of people, add last person to first team
            team1Roster.add(individualPlayer: unevaluatedPlayer)
        }
        
        print("Team 1:\(team1Roster)")
        print("Team1 Score\(sumTeam(team: team1Scores))")
        print("Team 2:\(team2Roster)")
        print("Team1 Score\(sumTeam(team: team2Scores))")
        
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
    
    mutating func add(individualPlayer: Person) {
        people.insert(individualPlayer.name)
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
let adam = Person(id: 4, name: "Adam")
let honza = Person(id: 5, name: "Honza")
let danya = Person(id: 6, name: "Danya")
let anicka = Person(id: 7, name: "Anicka")
let loran = Person(id: 8, name: "Loran")

public let testCombos = [
    Combo(person1: myles, person2: kaja, score: -1),
    Combo(person1: myles, person2: nora, score: 0),
    Combo(person1: myles, person2: xanthe, score: 2),
    Combo(person1: myles, person2: adam, score: 1),
    Combo(person1: myles, person2: honza, score: 2),
    Combo(person1: myles, person2: danya, score: 0),
    Combo(person1: myles, person2: anicka, score: 0),
    Combo(person1: myles, person2: loran, score: 3),
    
    Combo(person1: kaja, person2: nora, score: 1),
    Combo(person1: kaja, person2: xanthe, score: 0),
    Combo(person1: kaja, person2: adam, score: 0),
    Combo(person1: kaja, person2: honza, score: 0),
    Combo(person1: kaja, person2: danya, score: 2),
    Combo(person1: kaja, person2: anicka, score: 1),
    Combo(person1: kaja, person2: loran, score: -2),
    
    Combo(person1: nora, person2: xanthe, score: 3),
    Combo(person1: nora, person2: adam, score: -1),
    Combo(person1: nora, person2: honza, score: 0),
    Combo(person1: nora, person2: danya, score: 0),
    Combo(person1: nora, person2: anicka, score: 1),
    Combo(person1: nora, person2: loran, score: 0),
    
    Combo(person1: xanthe, person2: adam, score: -1),
    Combo(person1: xanthe, person2: honza, score: 2),
    Combo(person1: xanthe, person2: danya, score: 0),
    Combo(person1: xanthe, person2: anicka, score: 1),
    Combo(person1: xanthe, person2: loran, score: 1),
    
    Combo(person1: adam, person2: honza, score: 0),
    Combo(person1: adam, person2: danya, score: -1),
    Combo(person1: adam, person2: anicka, score: 2),
    Combo(person1: adam, person2: loran, score: -1),
    
    Combo(person1: honza, person2: danya, score: 0),
    Combo(person1: honza, person2: anicka, score: 0),
    Combo(person1: honza, person2: loran, score: 0),
    
    Combo(person1: danya, person2: anicka, score: 0),
    Combo(person1: danya, person2: loran, score: -1),
    
    Combo(person1: anicka, person2: loran, score: 0),
]

