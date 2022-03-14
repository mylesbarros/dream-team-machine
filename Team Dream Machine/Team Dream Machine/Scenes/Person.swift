//
//  Person.swift
//  Team Dream Machine
//
//  Created by Myles Barros on 01.03.2022.
//

import Foundation

struct Person: Identifiable, Hashable {

    // MARK: - Public Properties

    let name: String
    let id: UUID

    // MARK: - Initializers

    init(name: String) {
        self.name = name
        id = UUID()
    }
}
