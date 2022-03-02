//
//  File.swift
//  
//
//  Created by Xanthe Hammer on 2/26/22.
//

import Foundation

public struct TeamAllocation{
    public var team1 : Team
    public var team2 : Team
}

public struct Person: Hashable {
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}

public struct Combo {
    
    let person1: Person
    let person2: Person
    var score: Float
    
    public init(person1: Person, person2: Person, score: Float) {
        self.person1 = person1
        self.person2 = person2
        self.score = score
    }
    
}

public struct TeamResult {
    public let newTeam: Team
    public let score: Int
}

public final class TeamBuilder {
    
    public init() {}
    
    func sumTeam(team: [Combo]) -> Float{
        var sum : Float = 0
        for combo in team{
            sum += combo.score
        }
        return sum
    }
    
    private func averageCombos(combos: [Combo]) -> [Combo]{
        var consolidated : [Combo] = []
        for i in 0..<combos.count {
            var combo1 = combos[i]
            
            let comboWasAlreadyChecked = consolidated.contains(where: { alreadyEvaluatedCombo in
                let evaledComboPeople: [Person] = [alreadyEvaluatedCombo.person1, alreadyEvaluatedCombo.person2]
                
                return evaledComboPeople.contains(combo1.person1) && evaledComboPeople.contains(combo1.person2)
            })
            
            guard !comboWasAlreadyChecked else { continue }
            guard let combo2 = combos.first(where: {
                let combo1People = [combo1.person1, combo1.person2]
                return combo1People.contains($0.person1) && combo1People.contains($0.person2)
            }) else { continue }
            
            combo1.score = (combo1.score + combo2.score) / 2
            consolidated.append(combo1)
        }
        return consolidated
    }
    
    public func buildTeam(_ combos: [Combo]) -> TeamAllocation {
        
        var combos: [Combo] = combos
        //Average player intersections to account for differing opinions
        combos = averageCombos(combos: combos)
        
        //Sort combos desc
        combos.sort(by: { lhs, rhs in
            lhs.score > rhs.score
        })

        var team1Scores : [Combo] = []
        var team2Scores : [Combo] = []
        
        var team1Roster = Team()
        var team2Roster = Team()
        
        //Iterate through combos
        var evaluatedPlayers: [Person] = []
        for i in 0..<combos.count{
            let combo = combos[i]
            
            //Each person can only be on one time
            let comboPlayerWasAlreadyChecked = evaluatedPlayers.contains(where: { alreadyEvaluatedPerson in
                combo.person1 == alreadyEvaluatedPerson ||
                combo.person2 == alreadyEvaluatedPerson
            })
            
            guard !comboPlayerWasAlreadyChecked else { continue }
            
            //Add the combo to the team with the lower current score
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
        
        //Account for uneven numbers of people, add last person to first team
        var unevaluatedPlayers = allPlayers
        unevaluatedPlayers.subtract(evaluatedPlayers)
        assert(unevaluatedPlayers.count <= 1)
        if let unevaluatedPlayer = unevaluatedPlayers.first {
            team1Roster.add(individualPlayer: unevaluatedPlayer)
        }
        return TeamAllocation(team1: team1Roster, team2: team2Roster)
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

let myles = Person(name: "Myles")
let kaja = Person( name: "Kaja")
let nora = Person(name: "Nora")
let xanthe = Person(name: "Xanthe")
let adam = Person(name: "Adam")
let honza = Person(name: "Honza")
let danya = Person(name: "Danya")
let anicka = Person(name: "Anicka")
let loran = Person(name: "Loran")

public let testCombos = [
    Combo(person1: myles, person2: kaja, score: -1),
    Combo(person1: myles, person2: nora, score: 0),
    Combo(person1: myles, person2: xanthe, score: 2),
    Combo(person1: myles, person2: adam, score: 1),
    Combo(person1: myles, person2: honza, score: 2),
    Combo(person1: myles, person2: danya, score: 0),
    Combo(person1: myles, person2: anicka, score: 0),
    Combo(person1: myles, person2: loran, score: 3),
    
    Combo(person1: kaja, person2: myles, score: 1),
    Combo(person1: kaja, person2: nora, score: 1),
    Combo(person1: kaja, person2: xanthe, score: 0),
    Combo(person1: kaja, person2: adam, score: 0),
    Combo(person1: kaja, person2: honza, score: 0),
    Combo(person1: kaja, person2: danya, score: 2),
    Combo(person1: kaja, person2: anicka, score: 1),
    Combo(person1: kaja, person2: loran, score: -2),
    
    Combo(person1: nora, person2: myles, score: 0),
    Combo(person1: nora, person2: kaja, score: 0),
    Combo(person1: nora, person2: xanthe, score: 3),
    Combo(person1: nora, person2: adam, score: -1),
    Combo(person1: nora, person2: honza, score: 0),
    Combo(person1: nora, person2: danya, score: 0),
    Combo(person1: nora, person2: anicka, score: 1),
    Combo(person1: nora, person2: loran, score: 0),
    
    Combo(person1: xanthe, person2: myles, score: 3),
    Combo(person1: xanthe, person2: kaja, score: -1),
    Combo(person1: xanthe, person2: nora, score: 3),
    Combo(person1: xanthe, person2: adam, score: -1),
    Combo(person1: xanthe, person2: honza, score: 2),
    Combo(person1: xanthe, person2: danya, score: 0),
    Combo(person1: xanthe, person2: anicka, score: 1),
    Combo(person1: xanthe, person2: loran, score: 1),
    
    Combo(person1: adam, person2: myles, score: 2),
    Combo(person1: adam, person2: kaja, score: -1),
    Combo(person1: adam, person2: nora, score: -1),
    Combo(person1: adam, person2: xanthe, score: -1),
    Combo(person1: adam, person2: honza, score: 0),
    Combo(person1: adam, person2: danya, score: -1),
    Combo(person1: adam, person2: anicka, score: 2),
    Combo(person1: adam, person2: loran, score: -1),
    
    Combo(person1: honza, person2: myles, score: 3),
    Combo(person1: honza, person2: kaja, score: 2),
    Combo(person1: honza, person2: nora, score: 0),
    Combo(person1: honza, person2: xanthe, score: 0),
    Combo(person1: honza, person2: adam, score: 0),
    Combo(person1: honza, person2: danya, score: 0),
    Combo(person1: honza, person2: anicka, score: 0),
    Combo(person1: honza, person2: loran, score: 0),
    
    Combo(person1: danya, person2: myles, score: 0),
    Combo(person1: danya, person2: kaja, score: -1),
    Combo(person1: danya, person2: nora, score: 0),
    Combo(person1: danya, person2: xanthe, score: -1),
    Combo(person1: danya, person2: adam, score: 0),
    Combo(person1: danya, person2: honza, score: -1),
    Combo(person1: danya, person2: anicka, score: 0),
    Combo(person1: danya, person2: loran, score: -1),
    
    Combo(person1: anicka, person2: myles, score: 3),
    Combo(person1: anicka, person2: kaja, score: 1),
    Combo(person1: anicka, person2: nora, score: 2),
    Combo(person1: anicka, person2: xanthe, score: 3),
    Combo(person1: anicka, person2: adam, score: 1),
    Combo(person1: anicka, person2: honza, score: 0),
    Combo(person1: anicka, person2: danya, score: 1),
    Combo(person1: anicka, person2: loran, score: -1)
]

