//
//  FightViewController.swift
//  Project3
//
//  Created by Adrien PEREA on 01/04/2021.
//

import UIKit

class FightViewController: UIViewController {
    //initialisation des outlets du player1
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
    
    //initialisation des outlets du player2
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
    
    // décarations des variables d'action en cours
    var currentCharacter:Character?
    var currentTarget:Character?
    var currentAction = ""
    
    // an array of characters to set the order to play
    let currentCharacterArray = [player1.characters[0],player2.characters[0],player1.characters[1],player2.characters[1],player1.characters[2],player2.characters[2]]
    
    // index to set the current character increase after each action of the currentCharacter
    var currentCharacterIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // hide the navigation bar on this view
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
        //  initialise all labels on the view
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
    
    // function for refresh the health of all characters
    func refreshHealth(){
        player1Charac1HPLabel.text = String(player1.characters[0].race.health)
        player1Charac2HPLabel.text = String(player1.characters[1].race.health)
        player1Charac3HPLabel.text = String(player1.characters[2].race.health)
        player2Charac1HPLabel.text = String(player2.characters[0].race.health)
        player2Charac2HPLabel.text = String(player2.characters[1].race.health)
        player2Charac3HPLabel.text = String(player2.characters[2].race.health)
    }
    
    // function for enable/disable a button
    func activeButton(button:UIButton, active:Bool, alpha:Double){
        button.isEnabled = active
        button.alpha = CGFloat(alpha)
    }
    
    // set alpha 1 to the button of the currrent character
    func alphaCurrentCharacter(character:Character){
        if character == player1.characters[0] {
            player1Charac1Button.alpha = 1
        } else if character == player1.characters[1] {
            player1Charac2Button.alpha = 1
        } else if character == player1.characters[2] {
            player1Charac3Button.alpha = 1
        } else if character == player2.characters[0] {
            player2Charac1Button.alpha = 1
        } else if character == player2.characters[1] {
            player2Charac2Button.alpha = 1
        } else if character == player2.characters[2] {
            player2Charac3Button.alpha = 1
        }
    }
    
    // set the currentAction to Attack
    @IBAction func pushAttackButton(_ sender: Any) {
        // disable the button
        attackButton.isEnabled = false
        currentAction = "attack"
        // enable cancel button to change the choice
        activeButton(button: cancelButton, active: true, alpha: 1)
        // disable healbutton when attack is selected
        activeButton(button: healButton, active: false, alpha: 0.2)
        // if it's one character of the player 1, enable player2 character's button but if heath is > 0 else can't target a dead character
        if currentCharacter == player1.characters[0] || currentCharacter == player1.characters[1] || currentCharacter == player1.characters[2]{
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
        if currentCharacter == player2.characters[0] || currentCharacter == player2.characters[1] || currentCharacter == player2.characters[2]{
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
    
    // set the current action to heal
    @IBAction func pushHealButton(_ sender: Any) {
        healButton.isEnabled = false
        currentAction = "heal"
        cancelButton.isEnabled = true
        cancelButton.alpha = 1
        attackButton.isEnabled = false
        attackButton.alpha = 0.2
        if currentCharacter == player1.characters[0]{
            if (currentCharacter?.race.health)! < (currentCharacter?.race.healthMax)! {
            player1Charac1Button.isEnabled = true
            }
            if player1.characters[1].race.health > 0 && player1.characters[1].race.health < player1.characters[1].race.healthMax {
                activeButton(button: player1Charac2Button, active: true, alpha: 1)
            }
            if player1.characters[2].race.health > 0 && player1.characters[2].race.health < player1.characters[2].race.healthMax {
                activeButton(button: player1Charac3Button, active: true, alpha: 1)
            }
            
        }
        if currentCharacter == player1.characters[1]{
            if (currentCharacter?.race.health)! < (currentCharacter?.race.healthMax)! {
                player1Charac2Button.isEnabled = true
            }
            if player1.characters[0].race.health > 0 && player1.characters[0].race.health < player1.characters[0].race.healthMax {
                activeButton(button: player1Charac1Button, active: true, alpha: 1)
            }
            if player1.characters[2].race.health > 0 && player1.characters[2].race.health < player1.characters[2].race.healthMax {
                activeButton(button: player1Charac3Button, active: true, alpha: 1)
            }
        }
        if currentCharacter == player1.characters[2]{
            if (currentCharacter?.race.health)! < (currentCharacter?.race.healthMax)! {
                player1Charac3Button.isEnabled = true
            }
            if player1.characters[1].race.health > 0 && player1.characters[1].race.health < player1.characters[1].race.healthMax {
                activeButton(button: player1Charac2Button, active: true, alpha: 1)
            }
            if player1.characters[0].race.health > 0 && player1.characters[0].race.health < player1.characters[0].race.healthMax {
                activeButton(button: player1Charac1Button, active: true, alpha: 1)
            }
        }
        if currentCharacter == player2.characters[0]{
            if (currentCharacter?.race.health)! < (currentCharacter?.race.healthMax)! {
                player2Charac1Button.isEnabled = true
            }
            if player2.characters[1].race.health > 0 && player2.characters[1].race.health < player2.characters[1].race.healthMax {
                activeButton(button: player2Charac2Button, active: true, alpha: 1)
            }
            if player2.characters[2].race.health > 0 && player2.characters[2].race.health < player2.characters[2].race.healthMax {
                activeButton(button: player2Charac3Button, active: true, alpha: 1)
            }
        }
        if currentCharacter == player2.characters[1]{
            if (currentCharacter?.race.health)! < (currentCharacter?.race.healthMax)! {
                player2Charac2Button.isEnabled = true
            }
            if player2.characters[0].race.health > 0 && player2.characters[0].race.health < player2.characters[0].race.healthMax {
                activeButton(button: player2Charac1Button, active: true, alpha: 1)
            }
            if player2.characters[2].race.health > 0 && player2.characters[2].race.health < player2.characters[2].race.healthMax {
                activeButton(button: player2Charac3Button, active: true, alpha: 1)
            }
        }
        if currentCharacter == player2.characters[2]{
            if (currentCharacter?.race.health)! < (currentCharacter?.race.healthMax)! {
            player2Charac3Button.isEnabled = true
            }
            if player2.characters[1].race.health > 0 && player2.characters[1].race.health < player2.characters[1].race.healthMax {
                activeButton(button: player2Charac2Button, active: true, alpha: 1)
            }
            if player2.characters[0].race.health > 0 && player2.characters[0].race.health < player2.characters[0].race.healthMax {
                activeButton(button: player2Charac1Button, active: true, alpha: 1)
            }
        }
    }
    
    @IBAction func pushCancelButton(_ sender: Any) {
        currentAction = ""
        disableAllButton()
        activeButton(button: attackButton, active: true, alpha: 1)
        alphaCurrentCharacter(character: currentCharacter!)
        if (currentCharacter?.race.weapon.heal)! > 0 {
            activeButton(button: healButton, active: true, alpha: 1)
        }
        activeButton(button: cancelButton, active: false, alpha: 0.2)
    }
    
    // set the current target by pushing the characterButton
    @IBAction func pushP1C1(_ sender: Any) {
        currentTarget = player1.characters[0]
        doAction()
    }
    @IBAction func pushP1C2(_ sender: Any) {
        currentTarget = player1.characters[1]
        doAction()
    }
    @IBAction func pushP1C3(_ sender: Any) {
        currentTarget = player1.characters[2]
        doAction()
    }
    @IBAction func pushP2C1(_ sender: Any) {
        currentTarget = player2.characters[0]
        doAction()
    }
    @IBAction func pushP2C2(_ sender: Any) {
        currentTarget = player2.characters[1]
        doAction()
    }
    @IBAction func pushP2C3(_ sender: Any) {
        currentTarget = player2.characters[2]
        doAction()
    }
    
    // perform current action on current target
    func doAction() {
        if currentAction == "attack" {
            currentCharacter!.attack(ennemy: currentTarget!)
            // set life on 0 ( cannot be negative )
            if (currentTarget?.race.health)! < 0 {
                currentTarget?.race.health = 0
            }
        }
        if currentAction == "heal" {
            currentCharacter!.heal(ally: currentTarget!)
            // set life on max even if it heal more
            if (currentTarget?.race.health)! > (currentTarget?.race.healthMax)! {
                currentTarget?.race.health = (currentTarget?.race.healthMax)!
            }
        }
        refreshHealth()
        disableAllButton()
        // change the index to go to the next character of the array
        currentCharacterIndex += 1
        // if the last character play, go back to the first and increase a turn.
        if currentCharacterArray.count == currentCharacterIndex {
            currentCharacterIndex = 0
            game.totalTurn += 1
        }
        currentCharacter = currentCharacterArray[currentCharacterIndex]
        turn()
        isGameOver()
        if game.state == .isOver {
            performSegue(withIdentifier: "winView", sender: Any?.self)
        }
    }
    // convert the type race of characters to an emoji for the label button
    func convertRace(charac:Character) -> String {
        var race = ""
        if charac.race.type == "elf" {
            race = "🧝"
        }
        if charac.race.type == "human" {
            race = "👨"
        }
        if charac.race.type == "wizzard" {
            race = "🧙‍♂️"
        }
        if charac.race.type == "dwarf" {
            race = "🎅"
        }
        return race
    }
    
    // set all the button disable et alpha 0.2 before the current character was enable
    func disableAllButton() {
        activeButton(button: player1Charac1Button, active: false, alpha: 0.2)
        activeButton(button: player1Charac2Button, active: false, alpha: 0.2)
        activeButton(button: player1Charac3Button, active: false, alpha: 0.2)
        activeButton(button: player2Charac1Button, active: false, alpha: 0.2)
        activeButton(button: player2Charac2Button, active: false, alpha: 0.2)
        activeButton(button: player2Charac3Button, active: false, alpha: 0.2)
    }
    
    func turn(){
        disableAllButton()
        activeButton(button: cancelButton, active: false, alpha: 0.2)
        // set the current character
        currentCharacter = currentCharacterArray[currentCharacterIndex]
        // the currentCharacter can't be dead, else go to the next character
        guard (currentCharacter?.race.health)! > 0 else {
            currentCharacterIndex += 1
            // check if the current character is the last, then go back to the first
            if currentCharacterArray.count == currentCharacterIndex {
                currentCharacterIndex = 0
            }
            // set the new current character and do a turn() again
            currentCharacter = currentCharacterArray[currentCharacterIndex]
            return turn()
        }
        //set the alpha of the current character button to 1 to see who is the currentCharacter
        alphaCurrentCharacter(character: currentCharacter!)
        // show who is the current character by showing his name
        currentCharacterLabel.text = "\(currentCharacter!.name)'s turn"
        // show to the user the damage and heal his player can make"
        currentCharacterHealLabel.text = "+ \(currentCharacter!.race.weapon.heal)"
        currentCharacterAttackLabel.text = " - \(currentCharacter!.race.weapon.damage)"
        // enable the attack button (every character can attack)
        attackButton.isEnabled = true
        attackButton.alpha = 1
        // enable heal button is the character can do it
        if (currentCharacter?.race.weapon.heal)! > 0 {
            healButton.isEnabled = true
            healButton.alpha = 1
        } else {
            activeButton(button: healButton, active: false, alpha: 0.2)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "winView" {
            _ = segue.destination as! WinViewViewController
        }
        }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
