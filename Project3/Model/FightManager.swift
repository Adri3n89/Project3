//
//  FightManager.swift
//  Project3
//
//  Created by Adrien PEREA on 15/04/2021.
// swiftlint:disable all

import Foundation
import UIKit

protocol FightManagerDelegate {
    func alert()
    func putSkull(index: Int)
    func disableButton(index1: Int, index2: Int)
    func goToWinView()
    func refreshHP()
    func showAttackHeal(currentC: Character?)
    func activeButton(index: Int)
    func showToDo(currentC: Character?, currentP: Player)
}

class FightManager {
// MARK: - VARIABLES
    var delegate: FightManagerDelegate
    var currentP: Player?
    var currentPArray: [Player] = [player1, player2]
    let characterArray: [Character] = player1.characters + player2.characters
    var currentPIndex = 0
    var currentC: Character?
    var currentTarget: Character?
    var currentAction = ""
    var randomWeapon: Weapon?
    let game = Game()

        init(delegate: FightManagerDelegate) {
            self.delegate = delegate
        }

    // MARK: - FUNCTIONS
        
    // check health of all character of a player to enable the button for a heal
    func checkHealCharacter(player: Player, indexCurrentCharac: Int, coop1: Int, coop2: Int) {
        if currentC == player.characters[indexCurrentCharac] {
            if currentP?.name == player1.name {
                if currentC!.race.health < currentC!.race.healthMax {
                    delegate.activeButton(index: indexCurrentCharac)
                }
                if checkHealth(player, coop1) > 0 && checkHealth(player, coop1) < player.characters[coop1].race.healthMax {
                    delegate.activeButton(index: coop1)
                }
                if checkHealth(player, coop2) > 0 && checkHealth(player, coop2) < player.characters[coop2].race.healthMax {
                    delegate.activeButton(index: coop2)
                }
            } else {
                if currentC!.race.health < currentC!.race.healthMax {
                    delegate.activeButton(index: indexCurrentCharac+3)
                }
                if checkHealth(player, coop1) > 0 && checkHealth(player, coop1) < player.characters[coop1].race.healthMax {
                    delegate.activeButton(index: coop1+3)
                }
                if checkHealth(player, coop2) > 0 && checkHealth(player, coop2) < player.characters[coop2].race.healthMax {
                    delegate.activeButton(index: coop2+3)
                }
            }
        }
    }

    func chooseCharacterOrTarget(choice: Character) {
        if currentAction == "" {
            currentC = choice
        } else {
            currentTarget = choice
        }
    }

    func turn() {
        if currentPIndex == currentPArray.count {
            currentPIndex = 0
        }
        currentP = currentPArray[currentPIndex]
        delegate.disableButton(index1: 0, index2: 8)
        // set the current player
        currentP = currentPArray[currentPIndex]
        if currentP?.characters[0].canPlay == false && currentP?.characters[1].canPlay == false && currentP?.characters[2].canPlay == false {
            currentPIndex += 1
            if currentPArray.count == currentPIndex {
                currentPIndex = 0
            }
        }
        if currentPIndex == 1 {
            for index in 3...5 {
                if characterArray[index].race.health > 0 && characterArray[index].canPlay == true {
                    delegate.activeButton(index: index)
                }
            }
        } else if currentPIndex == 0 {
            for index in 0...2 {
                if characterArray[index].race.health > 0 && characterArray[index].canPlay == true {
                    delegate.activeButton(index: index)
                }
            }
        }
        // show who is the current player and current character by showing his name
        delegate.showToDo(currentC: currentC, currentP: currentP!)
        // show to the user the damage and heal his player can make"
        if currentC != nil {
            delegate.activeButton(index: 6)
            if (currentC?.race.weapon.heal)! > 0 {
                delegate.activeButton(index: 7)
            }
        }
        delegate.showAttackHeal(currentC: currentC)
        if currentAction != "" && currentTarget != nil {
            doAction()
        }
    }

    // MARK: - PRIVATES FUNCTIONS
    private func characterIsDead(character: Character) {
        if character.race.health == 0 {
            character.canPlay = false
            for index in 0...5 {
                if character == characterArray[index] {
                    delegate.putSkull(index: index)
                }
            }
        }
    }

    // function for refresh the health of all characters
    private func refresh(characterArray: [Character]) {
        delegate.refreshHP()
        currentAction = ""
        currentTarget = nil
        currentC = nil
        for index in 0...2 {
            characterIsDead(character: player1.characters[index])
            characterIsDead(character: player2.characters[index])
        }
    }

    private func doAction() {
        randomChest()
        if currentAction == "attack" {
            attack()
        }
        if currentAction == "heal" {
            heal()
        }
        characterIsDead(character: currentTarget!)
        isGameOver()
        if game.state == .isOver {
            delegate.goToWinView()
        } else {
            currentC!.canPlay = false
            currentPIndex += 1
            checkTurn()
            delegate.disableButton(index1: 0, index2: 5)
            // change the index to go to the next character of the array
            // if the last character played, go back to the first
        if currentPArray.count == currentPIndex {
            currentPIndex = 0
        }
        currentP = currentPArray[currentPIndex]
        refresh(characterArray: characterArray)
        turn()
        }
    }

    // set the game on isOver and a winner
    private func isGameOver() {
        if checkHealth(player1, 0) == 0 && checkHealth(player1, 1) == 0 && checkHealth(player1, 2) == 0 {
            game.winner = player2
            game.state = .isOver
        }
        if checkHealth(player2, 0) == 0 && checkHealth(player2, 1) == 0 && checkHealth(player2, 2) == 0 {
            game.state = .isOver
            game.winner = player1
        }
    }

    private func attack() {
        currentC!.attack(ennemy: currentTarget!)
        // set life on 0 ( cannot be negative )
        if (currentTarget?.race.health)! < 0 {
            currentTarget?.race.health = 0
        }
    }

    private func heal() {
        currentC!.heal(ally: currentTarget!)
        // set life on max even if it heal more
        if (currentTarget?.race.health)! > (currentTarget?.race.healthMax)! {
            currentTarget?.race.health = (currentTarget?.race.healthMax)!
        }
    }

    // increase totalTurn after all alive's character played
    private func checkTurn() {
        var characterPlayed = 0
        for character in characterArray where character.canPlay == false {
            characterPlayed += 1
        }
        if characterPlayed == 6 {
            game.totalTurn += 1
            currentPIndex = 0
            for character in characterArray where character.race.health > 0 {
                character.canPlay = true
            }
        }
    }

    // return health of a character
    private func checkHealth(_ player: Player, _ index: Int) -> Int {
        return player.characters[index].race.health
    }

    // pop a Weapon and equip it to the currentCharacter
    private func randomChest() {
        let randomNumber2: Int = .random(in: 0...3)
        let randomNumber: Int = .random(in: 0...2)
        if randomNumber2 == 2 {
        switch currentC!.race.type {
        case .elf : randomWeapon = arrayBow[randomNumber]
        case .dwarf : randomWeapon = arrayAxe[randomNumber]
        case .human : randomWeapon = arraySword[randomNumber]
        case .wizzard : randomWeapon = arrayStick[randomNumber]
        }
        currentC!.race.weapon = randomWeapon!
            delegate.alert()
        }
    }
}
