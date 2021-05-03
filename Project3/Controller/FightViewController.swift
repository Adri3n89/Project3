//
//  FightViewController.swift
//  Project3
//
//  Created by Adrien PEREA on 01/04/2021.
// swiftlint:disable line_length

import UIKit

class FightViewController: UIViewController {
    // MARK: - @IBOUTLETS
    // initialisation des outlets du player1
    @IBOutlet weak var player1NameLabel: UILabel!
    // initialisation des outlets du player2
    @IBOutlet weak var player2NameLabel: UILabel!
    // déclaration des boutons d'actions et labels attack / heal
    @IBOutlet weak var currentCharacterAttackLabel: UILabel!
    @IBOutlet weak var currentCharacterHealLabel: UILabel!
    @IBOutlet weak var currentCharacterLabel: UILabel!
    // array of buttons, name and hp for the six characters
    @IBOutlet var allCharacterName: [UILabel]!
    @IBOutlet var allCharacterHP: [UILabel]!
    @IBOutlet var allButtons: [UIButton]!

    // MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // hide the navigation bar on this view
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
        //  initialise all labels on the view
        player1NameLabel.text = "⚔️ \(player1.name.capitalized) ⚔️"
        player2NameLabel.text = "⚔️ \(player2.name.capitalized) ⚔️"
        setupFightView(characterArray: characterArray, nameLabelArray: allCharacterName, hpLabelArray: allCharacterHP, buttonCharacterArray: allButtons)
        for character in characterArray {
            print(character.canPlay)
            print(character.name)
        }
        // launch the game
//        while game.state == .isOngoing {
            turn(allButtonArray: allButtons, currentCLabel: currentCharacterLabel, currentCHeal: currentCharacterHealLabel, currentCAttack: currentCharacterAttackLabel, view: self, hpLabelArray: allCharacterHP)
//        }
    }

    // MARK: - @IBACTIONS
    // set the current target or currentCharacter by pushing the characterButton
    @IBAction func pushP1C1(_ sender: Any) {
        letsBounce(button: allButtons[0])
        chooseCharacterOrTarget(choice: player1.characters[0])
        turn(allButtonArray: allButtons, currentCLabel: currentCharacterLabel, currentCHeal: currentCharacterHealLabel, currentCAttack: currentCharacterAttackLabel, view: self, hpLabelArray: allCharacterHP)
    }
    @IBAction func pushP1C2(_ sender: Any) {
        letsBounce(button: allButtons[1])
        chooseCharacterOrTarget(choice: player1.characters[1])
        turn(allButtonArray: allButtons, currentCLabel: currentCharacterLabel, currentCHeal: currentCharacterHealLabel, currentCAttack: currentCharacterAttackLabel, view: self, hpLabelArray: allCharacterHP)
    }
    @IBAction func pushP1C3(_ sender: Any) {
        letsBounce(button: allButtons[2])
        chooseCharacterOrTarget(choice: player1.characters[2])
        turn(allButtonArray: allButtons, currentCLabel: currentCharacterLabel, currentCHeal: currentCharacterHealLabel, currentCAttack: currentCharacterAttackLabel, view: self, hpLabelArray: allCharacterHP)
    }
    @IBAction func pushP2C1(_ sender: Any) {
        letsBounce(button: allButtons[3])
        chooseCharacterOrTarget(choice: player2.characters[0])
        turn(allButtonArray: allButtons, currentCLabel: currentCharacterLabel, currentCHeal: currentCharacterHealLabel, currentCAttack: currentCharacterAttackLabel, view: self, hpLabelArray: allCharacterHP)
    }
    @IBAction func pushP2C2(_ sender: Any) {
        letsBounce(button: allButtons[4])
        chooseCharacterOrTarget(choice: player2.characters[1])
        turn(allButtonArray: allButtons, currentCLabel: currentCharacterLabel, currentCHeal: currentCharacterHealLabel, currentCAttack: currentCharacterAttackLabel, view: self, hpLabelArray: allCharacterHP)
    }
    @IBAction func pushP2C3(_ sender: Any) {
        letsBounce(button: allButtons[5])
        chooseCharacterOrTarget(choice: player2.characters[2])
        turn(allButtonArray: allButtons, currentCLabel: currentCharacterLabel, currentCHeal: currentCharacterHealLabel, currentCAttack: currentCharacterAttackLabel, view: self, hpLabelArray: allCharacterHP)
    }

    // set the current action to heal
    @IBAction func pushHealButton(_ sender: Any) {
       letsBounce(button: allButtons[7])
        disableAllButton(buttonArray: allButtons, index1: 0, index2: 5)
        currentAction = "heal"
        activeButton(button: allButtons[7], active: false, alpha: 1)
        activeButton(button: allButtons[6], active: false, alpha: 0.2)
        activeButton(button: allButtons[8], active: true, alpha: 1)
        checkHealCharacter(player: player1, indexCurrentCharac: 0, coop1: 1, coop2: 2, currentCharacButton: allButtons[0], coop1Button: allButtons[1], coop2Button: allButtons[2])
        checkHealCharacter(player: player1, indexCurrentCharac: 1, coop1: 0, coop2: 2, currentCharacButton: allButtons[1], coop1Button: allButtons[0], coop2Button: allButtons[2])
        checkHealCharacter(player: player1, indexCurrentCharac: 2, coop1: 0, coop2: 1, currentCharacButton: allButtons[2], coop1Button: allButtons[0], coop2Button: allButtons[1])
        checkHealCharacter(player: player2, indexCurrentCharac: 0, coop1: 1, coop2: 2, currentCharacButton: allButtons[3], coop1Button: allButtons[4], coop2Button: allButtons[5])
        checkHealCharacter(player: player2, indexCurrentCharac: 1, coop1: 0, coop2: 2, currentCharacButton: allButtons[4], coop1Button: allButtons[3], coop2Button: allButtons[5])
        checkHealCharacter(player: player2, indexCurrentCharac: 2, coop1: 0, coop2: 1, currentCharacButton: allButtons[5], coop1Button: allButtons[3], coop2Button: allButtons[4])
    }

    // set the currentAction to Attack
    @IBAction func pushAttackButton(_ sender: Any) {
        letsBounce(button: allButtons[6])
        // disable the button
        allButtons[6].isEnabled = false
        currentAction = "attack"
        activeButton(button: allButtons[6], active: false, alpha: 0.2)
        // enable cancel button to change the choice
        activeButton(button: allButtons[8], active: true, alpha: 1)
        // disable healbutton when attack is selected
        activeButton(button: allButtons[7], active: false, alpha: 0.2)
        // enable target if health > 0
        if currentC == player1.characters[0] || currentC == player1.characters[1] || currentC == player1.characters[2] {
            for index in 0...2 {
                activeButton(button: allButtons[index], active: false, alpha: 0.2)
            }
            for index in 3...5 where characterArray[index].race.health > 0 {
                    activeButton(button: allButtons[index], active: true, alpha: 1)
            }
        }
        // same if it's one character of the player 2 , and check if the character is dead to no target a dead character
        if currentC == player2.characters[0] || currentC == player2.characters[1] || currentC == player2.characters[2] {
            for index in 3...5 {
                activeButton(button: allButtons[index], active: false, alpha: 0.2)
            }
            for index in 0...2 where characterArray[index].race.health > 0 {
                    activeButton(button: allButtons[index], active: true, alpha: 1)
            }
        }
    }

    // cancel the current action
    @IBAction func pushCancelButton(_ sender: Any) {
        letsBounce(button: allButtons[8])
        currentAction = ""
        disableAllButton(buttonArray: allButtons, index1: 0, index2: 5)
        activeButton(button: allButtons[6], active: true, alpha: 1)
        if currentPIndex == 1 {
            for index in 3...5 {
                if characterArray[index].race.health > 0 && characterArray[index].canPlay == true {
                    activeButton(button: allButtons[index], active: true, alpha: 1)
                }
            }
        } else {
            for index in 0...2 {
                if characterArray[index].race.health > 0 && characterArray[index].canPlay == true {
                    activeButton(button: allButtons[index], active: true, alpha: 1)
                }
            }
        }
        if (currentC?.race.weapon.heal)! > 0 {
            activeButton(button: allButtons[7], active: true, alpha: 1)
        }
        activeButton(button: allButtons[8], active: false, alpha: 0.2)
    }
}
