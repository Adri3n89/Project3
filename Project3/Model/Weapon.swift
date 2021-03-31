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
var weakBow = Weapon(name:"bow", damage: 15, heal: 0)
var strongBow = Weapon(name:"bow", damage: 45, heal: 0)

// creation des 3 types d'épées
var baseSword = Weapon(name:"sword", damage: 50, heal: 0)
var weakSword = Weapon(name:"sword", damage: 25, heal: 0)
var strongSword = Weapon(name:"sword", damage: 75, heal: 0)

// creation des 3 types de batons
var baseStick = Weapon(name:"stick", damage: 15, heal: 25)
var weakStick = Weapon(name:"stick", damage: 10, heal: 15)
var strongStick = Weapon(name:"stick", damage: 20, heal: 35)

// creation des 3 type d'haches
var baseAxe = Weapon(name:"axe", damage: 40, heal: 0)
var weakAxe = Weapon(name:"axe", damage: 20, heal: 0)
var strongAxe = Weapon(name:"axe", damage: 60, heal: 0)
