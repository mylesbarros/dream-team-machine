//
//  Person.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 01.03.2022.
//

import Foundation

struct Person: Identifiable, Hashable {

    let name: String
    let id: UUID

    init(name: String) {
        self.name = name
        id = UUID()
    }
}
