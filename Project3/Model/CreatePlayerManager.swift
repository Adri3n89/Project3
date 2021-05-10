//
//  CreatePlayerManager.swift
//  Project3
//
//  Created by Adrien PEREA on 30/04/2021.
// swiftlint:disable all

import Foundation
import UIKit

// déclaration of protocol
protocol CreatePlayerManagerDelegate {
    func createCharacterSuccess()
    func createError(error: String)
    func createPlayer1Success()
    func createPlayer2Success()
}

class CreatePlayerManager {
    // MARK: VARIABLES
    var delegate: CreatePlayerManagerDelegate
    var race: Race?
    var characRaceSelected: String?
    let characRace: [String] = ["Elf", "Human", "Wizzard", "Dwarf"]
    var isPlayer2: Bool = false

    init(delegate: CreatePlayerManagerDelegate) {
        self.delegate = delegate
    }

    // MARK: FUNCTIONS
    func createCharacterPlayer1(name: String, race: Race) {
        var sameName = 0
        let character = Character(name: name, race: race)
        // check if the character's name have 3 letters
        if name.count < 3 {
            delegate.createError(error: character3Letters)
        // if it's the first character, no other check needed
        } else if player1.characters.count == 0 {
            player1.characters.append(character)
            delegate.createCharacterSuccess()
        // alert if player want create a 4th character
        } else if player1.characters.count > 2 {
            delegate.createError(error: character3Max)
        // check with the firsts characters
        } else {
            for index in 0...player1.characters.count-1 where checkName(character, player1, index) {
                sameName += 1
            }
            if sameName > 0 {
                delegate.createError(error: character2Names)
                sameName = 0
            } else {
                player1.characters.append(character)
                delegate.createCharacterSuccess()
            }
        }
    }

    func createCharacterPlayer2(name: String, race: Race) {
        var sameName = 0
        let character = Character(name: name, race: race)
        // check if the character's name have 3 letters
        if name.count < 3 {
            delegate.createError(error: character3Letters)
            // if it's the first character, only check with first player characters
        } else if player2.characters.count == 0 {
            for index in 0...player1.characters.count-1 where checkName(character, player1, index) {
                sameName += 1
            }
            if sameName > 0 {
                delegate.createError(error: characterP2P1)
                sameName = 0
            } else {
                player2.characters.append(character)
                delegate.createCharacterSuccess()
            }
        // alert if player want create a 4th character
        } else if player2.characters.count > 2 {
            delegate.createError(error: character3Max)
        // check with the player 2 characters
        } else {
            for index in 0...player2.characters.count-1 where checkName(character, player2, index) {
                sameName += 1
            }
            if sameName > 0 {
                delegate.createError(error: character2Names)
                sameName = 0
            // check with the player 1 characters
            } else {
                for index in 0...player1.characters.count-1 where checkName(character, player1, index) {
                    sameName += 1
                }
                if sameName > 0 {
                    delegate.createError(error: characterP2P1)
                    sameName = 0
                } else {
                    player2.characters.append(character)
                    delegate.createCharacterSuccess()
                }
            }
        }
    }

    func createPlayer1(name: String) {
        player1.name = name
        if player1.characters.count < 3 {
            delegate.createError(error: characterTeamMini)
        } else if name.count < 3 {
            delegate.createError(error: player3Letters)
        } else {
            isPlayer2 = true
            delegate.createPlayer1Success()
        }
    }

    func createPlayer2(name: String) {
        player2.name = name
        if player2.characters.count < 3 {
            delegate.createError(error: characterTeamMini)
        } else if player2.name.count < 3 {
            delegate.createError(error: player3Letters)
        } else if player2.name.capitalized == player1.name.capitalized {
            delegate.createError(error: player2Names)
        } else {
            delegate.createPlayer2Success()
        }
    }
    
    // MARK: PRIVATE FUNC
    // check the newCharacter name
    private func checkName(_ newCharac: Character, _ player: Player, _ index: Int) -> Bool {
        return newCharac.name.capitalized == player.characters[index].name.capitalized
    }

}
