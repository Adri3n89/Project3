//
//  FightManager.swift
//  Project3
//
//  Created by Adrien PEREA on 15/04/2021.
// swiftlint:disable line_length function_parameter_count cyclomatic_complexity

import Foundation
import UIKit

// MARK: - VARIABLES
var currentP: Player?
var currentPArray: [Player] = [player1, player2]
let characterArray: [Character] = [player1.characters[0], player1.characters[1], player1.characters[2], player2.characters[0], player2.characters[1], player2.characters[2]]
var currentPIndex = 0
var currentC: Character?
var currentTarget: Character?
var currentAction = ""
var randomWeapon: Weapon?
let game = Game()
var player1 = Player()
var player2 = Player()

// MARK: - FUNCTIONS
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
func checkTurn() {
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
func letsBounce(button: UIButton) {
    button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
    UIView.animate(withDuration: 0.5) {button.transform = CGAffineTransform.identity}
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
func checkHealth(_ player: Player, _ index: Int) -> Int {
    return player.characters[index].race.health
}
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
func randomChest(view: UIViewController) {
    let randomNumber2: Int = .random(in: 0...4)
    let randomNumber: Int = .random(in: 0...2)
    if randomNumber2 == 2 {
    switch currentC!.race.type {
    case .elf : randomWeapon = arrayBow[randomNumber]
    case .dwarf : randomWeapon = arrayAxe[randomNumber]
    case .human : randomWeapon = arraySword[randomNumber]
    case .wizzard : randomWeapon = arrayStick[randomNumber]
    }
    currentC!.race.weapon = randomWeapon!
    // probleme affiche les bons dégats dans la console mais pas dans l'alerte
    print("\(randomWeapon!) + \(randomWeapon!.damage) + \(randomWeapon!.heal)")
    let alertController = UIAlertController(title: "🎁", message: message, preferredStyle: .alert)
    let presentChest = UIAlertAction(title: okString, style: .default, handler: { _ in
        isGameOver()
    })
    alertController.addAction(presentChest)
    view.present(alertController, animated: true)
    }
}
// set all the button disable et alpha 0.2 before the current character was enable
func disableAllButton(buttonArray: [UIButton], index1: Int, index2: Int) {
    for index in index1...index2 {
        activeButton(button: buttonArray[index], active: false, alpha: 0.2)
    }
}
func setupFightView(characterArray: [Character], nameLabelArray: [UILabel], hpLabelArray: [UILabel], buttonCharacterArray: [UIButton]) {
    for index in 0...5 {
        nameLabelArray[index].text = characterArray[index].name.capitalized
        hpLabelArray[index].text = String(characterArray[index].race.health)
        buttonCharacterArray[index].setTitle(convertRace(charac: characterArray[index]), for: .normal)
    }
}
func characterIsDead(character: Character, buttonCharacterArray: [UIButton]) {
    if character.race.health == 0 {
        character.canPlay = false
        if character == player1.characters[0] {
            buttonCharacterArray[0].setTitle("💀", for: .normal)
        } else if character == player1.characters[1] {
            buttonCharacterArray[1].setTitle("💀", for: .normal)
        } else if character == player1.characters[2] {
            buttonCharacterArray[2].setTitle("💀", for: .normal)
        } else if character == player2.characters[0] {
            buttonCharacterArray[3].setTitle("💀", for: .normal)
        } else if character == player2.characters[1] {
            buttonCharacterArray[4].setTitle("💀", for: .normal)
        } else if character == player2.characters[2] {
            buttonCharacterArray[5].setTitle("💀", for: .normal)
        }
    }
}
// function for refresh the health of all characters
func refresh(characterArray: [Character], hpLabelArray: [UILabel], buttonCharacterArray: [UIButton]) {
    for index in 0...5 {
        hpLabelArray[index].text = String(characterArray[index].race.health)
    }
    currentAction = ""
    currentTarget = nil
    currentC = nil
    for index in 0...2 {
        characterIsDead(character: player1.characters[index], buttonCharacterArray: buttonCharacterArray)
        characterIsDead(character: player2.characters[index], buttonCharacterArray: buttonCharacterArray)
    }
}
func chooseCharacterOrTarget(choice: Character) {
    if currentAction == "" {
        currentC = choice
    } else {
        currentTarget = choice
    }
}
func doAction(view: UIViewController, buttonArray: [UIButton], hpLabelArray: [UILabel], currentCLabel: UILabel, currentCHeal: UILabel, currentCAttack: UILabel) {
    randomChest(view: view)
    if currentAction == "attack" {
        attack()
    }
    if currentAction == "heal" {
        heal()
    }
    isGameOver()
    print(game.state)
    if game.state == .isOver {
        view.performSegue(withIdentifier: "winView", sender: Any?.self)
    } else {
        currentC!.canPlay = false
        currentPIndex += 1
        checkTurn()
        disableAllButton(buttonArray: buttonArray, index1: 0, index2: 5)
        // change the index to go to the next character of the array
        // if the last character play, go back to the first and increase a turn.
    if currentPArray.count == currentPIndex {
        currentPIndex = 0
    }
    currentP = currentPArray[currentPIndex]
    refresh(characterArray: characterArray, hpLabelArray: hpLabelArray, buttonCharacterArray: buttonArray)
    turn(allButtonArray: buttonArray, currentCLabel: currentCLabel, currentCHeal: currentCHeal, currentCAttack: currentCAttack, view: view, hpLabelArray: hpLabelArray)
    }
}
func turn(allButtonArray: [UIButton], currentCLabel: UILabel, currentCHeal: UILabel, currentCAttack: UILabel, view: UIViewController, hpLabelArray: [UILabel]) {
    if currentPIndex == currentPArray.count {
        currentPIndex = 0
    }
    currentP = currentPArray[currentPIndex]
    print(currentP!.name)
    disableAllButton(buttonArray: allButtonArray, index1: 0, index2: 8)
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
                activeButton(button: allButtonArray[index], active: true, alpha: 1)
            }
        }
    } else if currentPIndex == 0 {
        for index in 0...2 {
            if characterArray[index].race.health > 0 && characterArray[index].canPlay == true {
                activeButton(button: allButtonArray[index], active: true, alpha: 1)
                print(allButtonArray[index].titleLabel!)
            }
        }
    }
    // show who is the current character by showing his name
    if currentC == nil {
        currentCLabel.text = "\(currentP!.name) choose a character"
    } else {
        currentCLabel.text = "\(currentC!.name) choose an attack and target"
    }
    // show to the user the damage and heal his player can make"
    if currentC != nil {
        activeButton(button: allButtonArray[6], active: true, alpha: 1)
        if (currentC?.race.weapon.heal)! > 0 {
            activeButton(button: allButtonArray[7], active: true, alpha: 1)
        }
        currentCHeal.text = "+ \(currentC!.race.weapon.heal)"
        currentCAttack.text = " - \(currentC!.race.weapon.damage)"
    } else {
        currentCHeal.text = "-"
        currentCAttack.text = "-"
    }
    if currentAction != "" && currentTarget != nil {
        doAction(view: view, buttonArray: allButtonArray, hpLabelArray: hpLabelArray, currentCLabel: currentCLabel, currentCHeal: currentCHeal, currentCAttack: currentCAttack)
    }
}
