//
//  Race.swift
//  Project3
//
//  Created by Adrien PEREA on 31/03/2021.
//

import Foundation
import UIKit

class Race {
    var weapon: Weapon
    var health: Int
    let healthMax: Int
    enum `Type`: String {
        case elf
        case human
        case wizzard
        case dwarf
    }
    var type: Type

    init(weapon: Weapon, health: Int, healthMax: Int, type: Type) {
        self.weapon = weapon
        self.health = health
        self.healthMax = healthMax
        self.type = type
    }
}
