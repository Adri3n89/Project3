//
//  Character.swift
//  Project3
//
//  Created by Adrien PEREA on 31/03/2021.
//

import Foundation

class Character {
    var name:String
    var race:Race
    
    func attack(ennemy:Character){
        ennemy.race.health -= race.weapon.damage
    }
    
    func heal(ally:Character){
        ally.race.health += race.weapon.heal
    }
    
    init(name: String, race:Race) {
        self.name = name
        self.race = race
    }
}

