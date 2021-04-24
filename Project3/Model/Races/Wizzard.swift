//
//  Wizzard.swift
//  Project3
//
//  Created by Adrien PEREA on 20/04/2021.
//

import Foundation

class Wizzard: Race {
    init() {
        super.init(weapon: BaseStick(), health: 250, healthMax: 250, type: .wizzard)
    }
}
