//
//  Weapon.swift
//  Project3
//
//  Created by Adrien PEREA on 31/03/2021.
//

import Foundation

class Weapon {
    var name: String
    var damage: Int
    var heal: Int

    init(name: String, damage: Int, heal: Int) {
        self.name = name
        self.damage = damage
        self.heal = heal
    }
}

let arrayBow = [BaseBow(), HealBow(), StrongBow()]
let arraySword = [BaseSword(), HealSword(), StrongSword()]
let arrayStick = [BaseStick(), HealStick(), StrongStick()]
let arrayAxe = [BaseAxe(), HealAxe(), StrongAxe()]
