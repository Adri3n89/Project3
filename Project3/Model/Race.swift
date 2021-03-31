//
//  Race.swift
//  Project3
//
//  Created by Adrien PEREA on 31/03/2021.
//

import Foundation

struct Race {
    var weapon:Weapon
    var health:Int
}



// creation des 4 race de personnage
var elf = Race(weapon: baseBow, health: 300)
var human = Race(weapon: baseSword, health: 200)
var wizzard = Race(weapon: baseStick, health: 250)
var dwarf = Race(weapon: baseAxe, health: 275)

// creation du tableau de race
var race = [elf,human,wizzard,dwarf]
