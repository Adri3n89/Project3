//
//  Elf.swift
//  Project3
//
//  Created by Adrien PEREA on 20/04/2021.
//

import Foundation

class Elf: Race {
    init() {
        super.init(weapon: BaseBow(), health: 300, healthMax: 300, type: .elf)
    }
}
