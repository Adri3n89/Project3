//
//  Character.swift
//  Project3
//
//  Created by Adrien PEREA on 31/03/2021.
//

import Foundation

class Character: Equatable {
    // add protocol Equatable to compare Character's name
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.name == rhs.name
    }

    var name: String
    var race: Race
    var canPlay = true

    init(name: String, race: Race) {
        self.name = name
        self.race = race
    }

    func attack(ennemy: Character) {
        ennemy.race.health -= race.weapon.damage
    }

    func heal(ally: Character) {
        ally.race.health += race.weapon.heal
    }
}
