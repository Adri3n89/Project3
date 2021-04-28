//
//  FightViewController.swift
//  Project3
//
//  Created by Adrien PEREA on 01/04/2021.
//

import UIKit
// swiftlint:disable:next type_body_length
class FightViewController: UIViewController {
    // initialisation des outlets du player1
    @IBOutlet weak var player1NameLabel: UILabel!
    @IBOutlet weak var player1Charac1NameLabel: UILabel!
    @IBOutlet weak var player1Charac1Button: UIButton!
    @IBOutlet weak var player1Charac1HPLabel: UILabel!
    @IBOutlet weak var player1Charac2NameLabel: UILabel!
    @IBOutlet weak var player1Charac2Button: UIButton!
    @IBOutlet weak var player1Charac2HPLabel: UILabel!
    @IBOutlet weak var player1Charac3NameLabel: UILabel!
    @IBOutlet weak var player1Charac3Button: UIButton!
    @IBOutlet weak var player1Charac3HPLabel: UILabel!

    // initialisation des outlets du player2
    @IBOutlet weak var player2NameLabel: UILabel!
    @IBOutlet weak var player2Charac1NameLabel: UILabel!
    @IBOutlet weak var player2Charac1Button: UIButton!
    @IBOutlet weak var player2Charac1HPLabel: UILabel!
    @IBOutlet weak var player2Charac2NameLabel: UILabel!
    @IBOutlet weak var player2Charac2Button: UIButton!
    @IBOutlet weak var player2Charac2HPLabel: UILabel!
    @IBOutlet weak var player2Charac3NameLabel: UILabel!
    @IBOutlet weak var player2Charac3Button: UIButton!
    @IBOutlet weak var player2Charac3HPLabel: UILabel!

    // déclaration des boutons d'actions et labels attack / heal
    @IBOutlet weak var attackButton: UIButton!
    @IBOutlet weak var healButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var currentCharacterAttackLabel: UILabel!
    @IBOutlet weak var currentCharacterHealLabel: UILabel!
    @IBOutlet weak var currentCharacterLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // hide the navigation bar on this view
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
        //  initialise all labels on the view
        game.state = .isOngoing
        game.totalTurn = 0
        for character in characterArray {
            character.race.health = character.race.healthMax
            character.canPlay = true
        }
        player1NameLabel.text = "⚔️ \(player1.name.capitalized) ⚔️"
        player1Charac1HPLabel.text = String(player1.characters[0].race.health)
        player1Charac1NameLabel.text = player1.characters[0].name.capitalized
        player1Charac1Button.setTitle(convertRace(charac: player1.characters[0]), for: .normal)
        player1Charac2HPLabel.text = String(player1.characters[1].race.health)
        player1Charac2NameLabel.text = player1.characters[1].name.capitalized
        player1Charac2Button.setTitle(convertRace(charac: player1.characters[1]), for: .normal)
        player1Charac3HPLabel.text = String(player1.characters[2].race.health)
        player1Charac3NameLabel.text = player1.characters[2].name.capitalized
        player1Charac3Button.setTitle(convertRace(charac: player1.characters[2]), for: .normal)
        player2NameLabel.text = "⚔️ \(player2.name.capitalized) ⚔️"
        player2Charac1HPLabel.text = String(player2.characters[0].race.health)
        player2Charac1NameLabel.text = player2.characters[0].name.capitalized
        player2Charac1Button.setTitle(convertRace(charac: player2.characters[0]), for: .normal)
        player2Charac2HPLabel.text = String(player2.characters[1].race.health)
        player2Charac2NameLabel.text = player2.characters[1].name.capitalized
        player2Charac2Button.setTitle(convertRace(charac: player2.characters[1]), for: .normal)
        player2Charac3HPLabel.text = String(player2.characters[2].race.health)
        player2Charac3NameLabel.text = player2.characters[2].name.capitalized
        player2Charac3Button.setTitle(convertRace(charac: player2.characters[2]), for: .normal)
        // launch the game
        turn()
    }

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

    // set all the button disable et alpha 0.2 before the current character was enable
    private func disableAllButton() {
        activeButton(button: player1Charac1Button, active: false, alpha: 0.2)
        activeButton(button: player1Charac2Button, active: false, alpha: 0.2)
        activeButton(button: player1Charac3Button, active: false, alpha: 0.2)
        activeButton(button: player2Charac1Button, active: false, alpha: 0.2)
        activeButton(button: player2Charac2Button, active: false, alpha: 0.2)
        activeButton(button: player2Charac3Button, active: false, alpha: 0.2)
    }

    // set alpha 1 to the button of the currrent character
    private func activateCharacterButton(character: Character) {
        if character == player1.characters[0] {
            activeButton(button: player1Charac1Button, active: true, alpha: 1)
        } else if character == player1.characters[1] {
            activeButton(button: player1Charac2Button, active: true, alpha: 1)
        } else if character == player1.characters[2] {
            activeButton(button: player1Charac3Button, active: true, alpha: 1)
        } else if character == player2.characters[0] {
            activeButton(button: player2Charac1Button, active: true, alpha: 1)
        } else if character == player2.characters[1] {
            activeButton(button: player2Charac2Button, active: true, alpha: 1)
        } else if character == player2.characters[2] {
            activeButton(button: player2Charac3Button, active: true, alpha: 1)
        }
    }

    private func characterIsDead(character: Character) {
        if character.race.health == 0 {
            character.canPlay = false
            if character == player1.characters[0] {
                player1Charac1Button.setTitle("💀", for: .normal)
            } else if character == player1.characters[1] {
                player1Charac2Button.setTitle("💀", for: .normal)
            } else if character == player1.characters[2] {
                player1Charac3Button.setTitle("💀", for: .normal)
            } else if character == player2.characters[0] {
                player2Charac1Button.setTitle("💀", for: .normal)
            } else if character == player2.characters[1] {
                player2Charac2Button.setTitle("💀", for: .normal)
            } else if character == player2.characters[2] {
                player2Charac3Button.setTitle("💀", for: .normal)
            }
        }
    }

    private func letsBounce(button: UIButton) {
        button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.5) {button.transform = CGAffineTransform.identity}
    }

    private func chooseCharacterOrTarget(choice: Character) {
        if currentAction == "" {
            currentC = choice
        } else {
            currentTarget = choice
        }
        turn()
    }

    // set the current target by pushing the characterButton
    @IBAction func pushP1C1(_ sender: Any) {
        letsBounce(button: player1Charac1Button)
        chooseCharacterOrTarget(choice: player1.characters[0])
    }

    @IBAction func pushP1C2(_ sender: Any) {
        letsBounce(button: player1Charac2Button)
        chooseCharacterOrTarget(choice: player1.characters[1])
    }

    @IBAction func pushP1C3(_ sender: Any) {
        letsBounce(button: player1Charac3Button)
        chooseCharacterOrTarget(choice: player1.characters[2])
    }

    @IBAction func pushP2C1(_ sender: Any) {
        letsBounce(button: player2Charac1Button)
        chooseCharacterOrTarget(choice: player2.characters[0])
    }

    @IBAction func pushP2C2(_ sender: Any) {
        letsBounce(button: player2Charac2Button)
        chooseCharacterOrTarget(choice: player2.characters[1])
    }

    @IBAction func pushP2C3(_ sender: Any) {
        letsBounce(button: player2Charac3Button)
        chooseCharacterOrTarget(choice: player2.characters[2])
    }

    func turn() {
        if currentPIndex == currentPArray.count {
            currentPIndex = 0
        }
        currentP = currentPArray[currentPIndex]
        print(currentP!.name)
        disableAllButton()
        activeButton(button: cancelButton, active: false, alpha: 0.2)
        activeButton(button: attackButton, active: false, alpha: 0.2)
        activeButton(button: healButton, active: false, alpha: 0.2)
        // set the current player
        currentP = currentPArray[currentPIndex]
        // swiftlint:disable:next line_length
        if currentP?.characters[0].canPlay == false && currentP?.characters[1].canPlay == false && currentP?.characters[2].canPlay == false {
            currentPIndex += 1
            if currentPArray.count == currentPIndex {
                currentPIndex = 0
            }
        turn()
        }
        for character in currentP!.characters {
            if character.race.health > 0 && character.canPlay == true {
                activateCharacterButton(character: character)
            }
        }
        // show who is the current character by showing his name
        if currentC == nil {
            currentCharacterLabel.text = "\(currentP!.name) choose a character"
        }
        // show to the user the damage and heal his player can make"
        if currentC != nil {
            activeButton(button: attackButton, active: true, alpha: 1)
            if (currentC?.race.weapon.heal)! > 0 {
                activeButton(button: healButton, active: true, alpha: 1)
            }
            currentCharacterHealLabel.text = "+ \(currentC!.race.weapon.heal)"
            currentCharacterAttackLabel.text = " - \(currentC!.race.weapon.damage)"
        } else {
            currentCharacterHealLabel.text = "-"
            currentCharacterAttackLabel.text = "-"
        }
        if currentAction != "" && currentTarget != nil {
            doAction()
        }
    }

    // function for refresh the health of all characters
    func refresh() {
    player1Charac1HPLabel.text = "\(player1.characters[0].race.health)"
    player1Charac2HPLabel.text = "\(player1.characters[1].race.health)"
    player1Charac3HPLabel.text = "\(player1.characters[2].race.health)"
    player2Charac1HPLabel.text = "\(player2.characters[0].race.health)"
    player2Charac2HPLabel.text = "\(player2.characters[1].race.health)"
    player2Charac3HPLabel.text = "\(player2.characters[2].race.health)"
    currentAction = ""
    currentTarget = nil
    currentC = nil
    for index in 0...2 {
        characterIsDead(character: player1.characters[index])
        characterIsDead(character: player2.characters[index])
    }
}

    // set the currentAction to Attack
    @IBAction func pushAttackButton(_ sender: Any) {
        letsBounce(button: attackButton)
        // disable the button
        attackButton.isEnabled = false
        currentAction = "attack"
        activeButton(button: cancelButton, active: false, alpha: 0.2)
        // enable cancel button to change the choice
        activeButton(button: cancelButton, active: true, alpha: 1)
        // disable healbutton when attack is selected
        activeButton(button: healButton, active: false, alpha: 0.2)
        // enable target if health > 0
        if currentC == player1.characters[0] || currentC == player1.characters[1] || currentC == player1.characters[2] {
            activeButton(button: player1Charac1Button, active: false, alpha: 0.2)
            activeButton(button: player1Charac2Button, active: false, alpha: 0.2)
            activeButton(button: player1Charac3Button, active: false, alpha: 0.2)
            if player2.characters[0].race.health > 0 {
                activeButton(button: player2Charac1Button, active: true, alpha: 1)
            }
            if player2.characters[1].race.health > 0 {
                activeButton(button: player2Charac2Button, active: true, alpha: 1)
            }
            if player2.characters[2].race.health > 0 {
                activeButton(button: player2Charac3Button, active: true, alpha: 1)
            }
        }
        // same if it's one character of the player 2 , and check if the character is dead to no target a dead character
        if currentC == player2.characters[0] || currentC == player2.characters[1] || currentC == player2.characters[2] {
            activeButton(button: player2Charac1Button, active: false, alpha: 0.2)
            activeButton(button: player2Charac2Button, active: false, alpha: 0.2)
            activeButton(button: player2Charac3Button, active: false, alpha: 0.2)
            if player1.characters[0].race.health > 0 {
                activeButton(button: player1Charac1Button, active: true, alpha: 1)
            }
            if player1.characters[1].race.health > 0 {
                activeButton(button: player1Charac2Button, active: true, alpha: 1)
            }
            if player1.characters[2].race.health > 0 {
                activeButton(button: player1Charac3Button, active: true, alpha: 1)
            }
        }
    }

    func randomChest() {
        let randomNumber: Int = .random(in: 0...2)
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
        })
        alertController.addAction(presentChest)
        self.present(alertController, animated: true)
        }

    // perform current action on current target
    func doAction() {
        let randomNumber2: Int = .random(in: 0...4)
        if randomNumber2 == 2 {
            randomChest()
        }
        action()
    }

    private func action() {
    if currentAction == "attack" {
       attack()
    }
    if currentAction == "heal" {
        heal()
    }
    isGameOver()
        print(game.state)
    if game.state == .isOver {
        performSegue(withIdentifier: "winView", sender: Any?.self)
    } else {
    currentC!.canPlay = false
    currentPIndex += 1
    checkTurn()
    disableAllButton()
    // change the index to go to the next character of the array
    // if the last character play, go back to the first and increase a turn.
    if currentPArray.count == currentPIndex {
        currentPIndex = 0
    }
    currentP = currentPArray[currentPIndex]
    refresh()
    turn()
    }
}

    // set the current action to heal
    @IBAction func pushHealButton(_ sender: Any) {
       letsBounce(button: healButton)
        disableAllButton()
        healButton.isEnabled = false
        currentAction = "heal"
        activeButton(button: cancelButton, active: true, alpha: 1)
        activeButton(button: attackButton, active: false, alpha: 0.2)
        // swiftlint:disable line_length
        checkHealCharacter(player: player1, indexCurrentCharac: 0, coop1: 1, coop2: 2, currentCharacButton: player1Charac1Button, coop1Button: player1Charac2Button, coop2Button: player1Charac3Button)
        checkHealCharacter(player: player1, indexCurrentCharac: 1, coop1: 0, coop2: 2, currentCharacButton: player1Charac2Button, coop1Button: player1Charac1Button, coop2Button: player1Charac3Button)
        checkHealCharacter(player: player1, indexCurrentCharac: 2, coop1: 0, coop2: 1, currentCharacButton: player1Charac3Button, coop1Button: player1Charac1Button, coop2Button: player1Charac2Button)
        checkHealCharacter(player: player2, indexCurrentCharac: 0, coop1: 1, coop2: 2, currentCharacButton: player2Charac1Button, coop1Button: player2Charac2Button, coop2Button: player2Charac3Button)
        checkHealCharacter(player: player2, indexCurrentCharac: 1, coop1: 0, coop2: 2, currentCharacButton: player2Charac2Button, coop1Button: player2Charac1Button, coop2Button: player2Charac3Button)
        checkHealCharacter(player: player2, indexCurrentCharac: 2, coop1: 0, coop2: 1, currentCharacButton: player2Charac3Button, coop1Button: player2Charac1Button, coop2Button: player2Charac2Button)
        // swiftlint:enable line_length
    }

    @IBAction func pushCancelButton(_ sender: Any) {
        letsBounce(button: cancelButton)
        currentAction = ""
        disableAllButton()
        activeButton(button: attackButton, active: true, alpha: 1)
        for character in currentP!.characters where character.race.health > 0 {
            activateCharacterButton(character: character)
        }
        if (currentC?.race.weapon.heal)! > 0 {
            activeButton(button: healButton, active: true, alpha: 1)
        }
        activeButton(button: cancelButton, active: false, alpha: 0.2)
    }
}
