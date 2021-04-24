//
//  Human.swift
//  Project3
//
//  Created by Adrien PEREA on 20/04/2021.
//

import Foundation

class Human: Race {
    init() {
        super.init(weapon: BaseSword(), health: 200, healthMax: 200, type: .human)
    }
}
