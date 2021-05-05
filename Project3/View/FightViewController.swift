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
    var fightManager: FightManager!

    // MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        fightManager = FightManager(delegate: self)
        // hide the navigation bar on this view
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
        //  initialise all labels on the view
        player1NameLabel.text = "⚔️ \(player1.name.capitalized) ⚔️"
        player2NameLabel.text = "⚔️ \(player2.name.capitalized) ⚔️"
        setupFightView(characterArray: fightManager.characterArray, nameLabelArray: allCharacterName, hpLabelArray: allCharacterHP, buttonCharacterArray: allButtons)
        // launch the game
        fightManager.turn()
        }

    // MARK: - @IBACTIONS
    // set the current target or currentCharacter by pushing the characterButton
    @IBAction func pushP1C1(_ sender: Any) {
        letsBounce(button: allButtons[0])
        fightManager.chooseCharacterOrTarget(choice: player1.characters[0])
        fightManager.turn()
    }
    @IBAction func pushP1C2(_ sender: Any) {
        letsBounce(button: allButtons[1])
        fightManager.chooseCharacterOrTarget(choice: player1.characters[1])
        fightManager.turn()
    }
    @IBAction func pushP1C3(_ sender: Any) {
        letsBounce(button: allButtons[2])
        fightManager.chooseCharacterOrTarget(choice: player1.characters[2])
        fightManager.turn()
    }
    @IBAction func pushP2C1(_ sender: Any) {
        letsBounce(button: allButtons[3])
        fightManager.chooseCharacterOrTarget(choice: player2.characters[0])
        fightManager.turn()
    }
    @IBAction func pushP2C2(_ sender: Any) {
        letsBounce(button: allButtons[4])
        fightManager.chooseCharacterOrTarget(choice: player2.characters[1])
        fightManager.turn()
    }
    @IBAction func pushP2C3(_ sender: Any) {
        letsBounce(button: allButtons[5])
        fightManager.chooseCharacterOrTarget(choice: player2.characters[2])
        fightManager.turn()
    }

    // set the current action to heal
    @IBAction func pushHealButton(_ sender: Any) {
       letsBounce(button: allButtons[7])
        disableAllButton(buttonArray: allButtons, index1: 0, index2: 5)
        fightManager.currentAction = "heal"
        activeButton(button: allButtons[7], active: false, alpha: 1)
        activeButton(button: allButtons[6], active: false, alpha: 0.2)
        activeButton(button: allButtons[8], active: true, alpha: 1)
        fightManager.checkHealCharacter(player: player1, indexCurrentCharac: 0, coop1: 1, coop2: 2)
        fightManager.checkHealCharacter(player: player1, indexCurrentCharac: 1, coop1: 0, coop2: 2)
        fightManager.checkHealCharacter(player: player1, indexCurrentCharac: 2, coop1: 0, coop2: 1)
        fightManager.checkHealCharacter(player: player2, indexCurrentCharac: 0, coop1: 1, coop2: 2)
        fightManager.checkHealCharacter(player: player2, indexCurrentCharac: 1, coop1: 0, coop2: 2)
        fightManager.checkHealCharacter(player: player2, indexCurrentCharac: 2, coop1: 0, coop2: 1)
    }

    // set the currentAction to Attack
    @IBAction func pushAttackButton(_ sender: Any) {
        letsBounce(button: allButtons[6])
        // disable the button
        allButtons[6].isEnabled = false
        fightManager.currentAction = "attack"
        activeButton(button: allButtons[6], active: false, alpha: 0.2)
        // enable cancel button to change the choice
        activeButton(button: allButtons[8], active: true, alpha: 1)
        // disable healbutton when attack is selected
        activeButton(button: allButtons[7], active: false, alpha: 0.2)
        // enable target if health > 0
        if fightManager.currentC == player1.characters[0] || fightManager.currentC == player1.characters[1] || fightManager.currentC == player1.characters[2] {
            for index in 0...2 {
                activeButton(button: allButtons[index], active: false, alpha: 0.2)
            }
            for index in 3...5 where fightManager.characterArray[index].race.health > 0 {
                    activeButton(button: allButtons[index], active: true, alpha: 1)
            }
        }
        // same if it's one character of the player 2 , and check if the character is dead to no target a dead character
        if fightManager.currentC == player2.characters[0] || fightManager.currentC == player2.characters[1] || fightManager.currentC == player2.characters[2] {
            for index in 3...5 {
                activeButton(button: allButtons[index], active: false, alpha: 0.2)
            }
            for index in 0...2 where fightManager.characterArray[index].race.health > 0 {
                    activeButton(button: allButtons[index], active: true, alpha: 1)
            }
        }
    }

    // cancel the current action
    @IBAction func pushCancelButton(_ sender: Any) {
        letsBounce(button: allButtons[8])
        fightManager.currentAction = ""
        disableAllButton(buttonArray: allButtons, index1: 0, index2: 5)
        activeButton(button: allButtons[6], active: true, alpha: 1)
        if fightManager.currentPIndex == 1 {
            for index in 3...5 {
                if fightManager.characterArray[index].race.health > 0 && fightManager.characterArray[index].canPlay == true {
                    activeButton(button: allButtons[index], active: true, alpha: 1)
                }
            }
        } else {
            for index in 0...2 {
                if fightManager.characterArray[index].race.health > 0 && fightManager.characterArray[index].canPlay == true {
                    activeButton(button: allButtons[index], active: true, alpha: 1)
                }
            }
        }
        if (fightManager.currentC?.race.weapon.heal)! > 0 {
            activeButton(button: allButtons[7], active: true, alpha: 1)
        }
        activeButton(button: allButtons[8], active: false, alpha: 0.2)
    }

    func letsBounce(button: UIButton) {
        button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.5) {button.transform = CGAffineTransform.identity}
    }

    func setupFightView(characterArray: [Character], nameLabelArray: [UILabel], hpLabelArray: [UILabel], buttonCharacterArray: [UIButton]) {
        for index in 0...5 {
            nameLabelArray[index].text = characterArray[index].name.capitalized
            hpLabelArray[index].text = String(characterArray[index].race.health)
            buttonCharacterArray[index].setTitle(convertRace(charac: characterArray[index]), for: .normal)
        }
    }

    // convert the type race of characters to an emoji for the label button
    private func convertRace(charac: Character) -> String {
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

    // set all the button disable et alpha 0.2 before the current character was enable
    func disableAllButton(buttonArray: [UIButton], index1: Int, index2: Int) {
        for index in index1...index2 {
            activeButton(button: buttonArray[index], active: false, alpha: 0.2)
        }
    }

    // function for enable/disable a button
    func activeButton(button: UIButton, active: Bool, alpha: Double) {
        button.isEnabled = active
        button.alpha = CGFloat(alpha)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "winView" {
            let next = segue.destination as? WinViewViewController
            next!.game = sender as? Game
        }
    }
}

extension FightViewController: FightManagerDelegate {

    func showToDo(currentC: Character?, currentP: Player) {
        guard currentC != nil else {
            currentCharacterLabel.text = "\(currentP.name) choose a character"
            return
        }
        currentCharacterLabel.text = "\(currentC!.name) choose an attack and a target"
    }

    func activeButton(index: Int) {
        activeButton(button: allButtons[index], active: true, alpha: 1)
    }

    func showAttackHeal(currentC: Character?) {
        guard currentC != nil else {
            currentCharacterHealLabel.text = "-"
            currentCharacterAttackLabel.text = "-"
            return
        }
            currentCharacterHealLabel.text = "+ \(currentC!.race.weapon.heal)"
            currentCharacterAttackLabel.text = " - \(currentC!.race.weapon.damage)"
        }

    func refreshHP() {
        for index in 0...5 {
            allCharacterHP[index].text = String(fightManager.characterArray[index].race.health)
        }
    }

    func goToWinView() {
        let item = fightManager.game
        self.performSegue(withIdentifier: "winView", sender: item)
    }

    func disableButton(index1: Int, index2: Int) {
        disableAllButton(buttonArray: allButtons, index1: index1, index2: index2)
    }

    func putSkull(index: Int) {
        allButtons[index].setTitle("💀", for: .normal)
    }

    func alert() {
        let alertController = UIAlertController(title: "🎁", message: "A treasure chest appears with a \(fightManager.randomWeapon!.name) inside\ndamage : \(fightManager.randomWeapon!.damage) heal : \(fightManager.randomWeapon!.heal)", preferredStyle: .alert)
        let presentChest = UIAlertAction(title: okString, style: .default, handler: {_ in
            if self.fightManager.game.state == .isOver {
                self.goToWinView()
                }
            })
        alertController.addAction(presentChest)
        self.present(alertController, animated: true)
    }

}
