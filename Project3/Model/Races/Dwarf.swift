//
//  Dwarf.swift
//  Project3
//
//  Created by Adrien PEREA on 20/04/2021.
//

import Foundation

class Dwarf: Race {
    init() {
        super.init(weapon: BaseAxe(), health: 275, healthMax: 275, type: .dwarf)
    }
}
