//
//  FightManager.swift
//  Project3
//
//  Created by Adrien PEREA on 15/04/2021.
//

import Foundation
import UIKit

// décarations des variables d'action en cours
var currentP: Player?
var currentPArray: [Player] = [player1, player2]
// swiftlint:disable:next line_length
let characterArray: [Character] = [player1.characters[0], player1.characters[1], player1.characters[2], player2.characters[0], player2.characters[1], player2.characters[2]]
var currentPIndex = 0
var currentC: Character?
var currentTarget: Character?
var currentAction = ""
var randomWeapon: Weapon?
let game = Game()
var player1 = Player()
var player2 = Player()
var characRaceSelected: String?
// creation des 4 race de personnage
let characRace: [String] = ["Elf", "Human", "Wizzard", "Dwarf"]

func isGameOver() {
    if checkHealth(player1, 0) == 0 && checkHealth(player1, 1) == 0 && checkHealth(player1, 2) == 0 {
        game.winner = player2
        game.state = .isOver
    }
    if checkHealth(player2, 0) == 0 && checkHealth(player2, 1) == 0 && checkHealth(player2, 2) == 0 {
        game.state = .isOver
        game.winner = player1
    }
}

func attack() {
    currentC!.attack(ennemy: currentTarget!)
    // set life on 0 ( cannot be negative )
    if (currentTarget?.race.health)! < 0 {
        currentTarget?.race.health = 0
    }
}

func heal() {
    currentC!.heal(ally: currentTarget!)
    // set life on max even if it heal more
    if (currentTarget?.race.health)! > (currentTarget?.race.healthMax)! {
        currentTarget?.race.health = (currentTarget?.race.healthMax)!
    }
}

func checkHealth(_ player: Player, _ index: Int) -> Int {
    return player.characters[index].race.health
}

// function for enable/disable a button
func activeButton(button: UIButton, active: Bool, alpha: Double) {
    button.isEnabled = active
    button.alpha = CGFloat(alpha)
}

// convert the type race of characters to an emoji for the label button
func convertRace(charac: Character) -> String {
        var race = ""
    if charac.race.type.rawValue == "elf" {
            race = "🧝"
        }
    if charac.race.type.rawValue == "human" {
            race = "👨"
        }
    if charac.race.type.rawValue == "wizzard" {
            race = "🧙‍♂️"
        }
    if charac.race.type.rawValue == "dwarf" {
            race = "🎅"
        }
        return race
    }

// swiftlint:disable:next line_length function_parameter_count
func checkHealCharacter(player: Player, indexCurrentCharac: Int, coop1: Int, coop2: Int, currentCharacButton: UIButton, coop1Button: UIButton, coop2Button: UIButton) {
    if currentC == player.characters[indexCurrentCharac] {
        if currentC!.race.health < currentC!.race.healthMax {
            activeButton(button: currentCharacButton, active: true, alpha: 1)
        }
        if checkHealth(player, coop1) > 0 && checkHealth(player, coop1) < player.characters[coop1].race.healthMax {
            activeButton(button: coop1Button, active: true, alpha: 1)
        }
        if checkHealth(player, coop2) > 0 && checkHealth(player, coop2) < player.characters[coop2].race.healthMax {
            activeButton(button: coop2Button, active: true, alpha: 1)
        }
    }
}
