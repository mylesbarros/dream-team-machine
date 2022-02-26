//
//  File.swift
//  
//
//  Created by Xanthe Hammer on 2/26/22.
//

import Foundation

struct Person {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func sayName() {
        print("Hello, my name is \(name)")
    }
    
}

