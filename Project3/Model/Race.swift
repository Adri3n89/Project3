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
    var type: String
}



// creation des 4 race de personnage
var elf = Race(weapon: baseBow, health: 300, type: "elf")
var human = Race(weapon: baseSword, health: 200, type: "human")
var wizzard = Race(weapon: baseStick, health: 250, type: "wizzard")
var dwarf = Race(weapon: baseAxe, health: 275, type: "dwarf")

// creation du tableau de race
var race:[String] = ["elf","human","wizzard","dwarf"]
