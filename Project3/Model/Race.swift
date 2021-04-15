//
//  Race.swift
//  Project3
//
//  Created by Adrien PEREA on 31/03/2021.
//

import Foundation
import UIKit

struct Race {
    var weapon:Weapon
    var health:Int
    let healthMax : Int
    var type: String
}
var characRaceSelected: Race?
// creation des 4 race de personnage
var characRace: [Race] = [
Race(weapon: baseBow, health: 300, healthMax: 300, type: "elf"),
Race(weapon: baseSword, health: 200, healthMax: 200, type: "human"),
Race(weapon: baseStick, health: 250, healthMax: 250, type: "wizzard"),
Race(weapon: baseAxe, health: 275, healthMax: 275, type: "dwarf")
]
