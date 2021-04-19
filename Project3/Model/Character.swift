//
//  Character.swift
//  Project3
//
//  Created by Adrien PEREA on 31/03/2021.
//

import Foundation

class Character: Equatable {
    // ajout de la fonction pour pouvoir comparer les nom des character
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.name == rhs.name
    }
    
    
    var name:String
    var race:Race
    var canPlay = true
    
    func attack(ennemy:Character) {
        ennemy.race.health -= race.weapon.damage
    }
    
    func heal(ally:Character) {
        ally.race.health += race.weapon.heal
    }
    
    init(name: String, race:Race) {
        self.name = name
        self.race = race
    }
}

