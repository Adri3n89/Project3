//
//  Weapon.swift
//  Project3
//
//  Created by Adrien PEREA on 31/03/2021.
//

import Foundation

struct Weapon {
    let name:String
    let damage:Int
    let heal:Int
}

// creation des 3 types d'arcs
let baseBow = Weapon(name:"bow", damage: 30, heal: 0)
let healBow = Weapon(name:"bow", damage: 20, heal: 15)
let strongBow = Weapon(name:"bow", damage: 55, heal: 0)
let arrayBow = [baseBow, healBow, strongBow]

// creation des 3 types d'épées
let baseSword = Weapon(name:"sword", damage: 50, heal: 0)
let healSword = Weapon(name:"sword", damage: 30, heal: 15)
let strongSword = Weapon(name:"sword", damage: 75, heal: 0)
let arraySword = [baseSword, healSword, strongSword]

// creation des 3 types de batons
let baseStick = Weapon(name:"stick", damage: 15, heal: 25)
let healStick = Weapon(name:"stick", damage: 10, heal: 35)
let strongStick = Weapon(name:"stick", damage: 40, heal: 20)
let arrayStick = [baseStick, healStick, strongStick]

// creation des 3 type d'haches
let baseAxe = Weapon(name:"axe", damage: 40, heal: 0)
let healAxe = Weapon(name:"axe", damage: 20, heal: 15)
let strongAxe = Weapon(name:"axe", damage: 65, heal: 0)
let arrayAxe = [baseAxe, healAxe, strongAxe]
