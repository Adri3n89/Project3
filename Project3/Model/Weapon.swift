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
var baseBow = Weapon(name:"bow", damage: 30, heal: 0)
var healBow = Weapon(name:"bow", damage: 20, heal: 15)
var strongBow = Weapon(name:"bow", damage: 55, heal: 0)

// creation des 3 types d'épées
var baseSword = Weapon(name:"sword", damage: 50, heal: 0)
var healSword = Weapon(name:"sword", damage: 30, heal: 15)
var strongSword = Weapon(name:"sword", damage: 75, heal: 0)

// creation des 3 types de batons
var baseStick = Weapon(name:"stick", damage: 15, heal: 25)
var healStick = Weapon(name:"stick", damage: 10, heal: 35)
var strongStick = Weapon(name:"stick", damage: 40, heal: 20)

// creation des 3 type d'haches
var baseAxe = Weapon(name:"axe", damage: 40, heal: 0)
var healAxe = Weapon(name:"axe", damage: 20, heal: 15)
var strongAxe = Weapon(name:"axe", damage: 65, heal: 0)
