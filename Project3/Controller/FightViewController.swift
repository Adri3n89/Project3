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
    var currentPlayer:Player?
    var currentPlayerArray:[Player] = [player1, player2]
    let characterArray:[Character] = [player1.characters[0],player1.characters[1],player1.characters[2],player2.characters[0],player2.characters[1],player2.characters[2]]
    var currentPlayerIndex = 0
    var currentCharacter:Character?
    var currentTarget:Character?
    var currentAction = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // hide the navigation bar on this view
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
        //  initialise all labels on the view
        game.state = .isOngoing
        currentPlayerIndex = 0
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
    
    func checkTurn(){
    var characterPlayed = 0
    for character in characterArray {
        if character.canPlay == false {
            characterPlayed += 1
        }
    }
    if characterPlayed == 6 {
        game.totalTurn += 1
        currentPlayerIndex = 0
        for character in characterArray {
            if character.race.health > 0 {
                character.canPlay = true
            }
        }
    }
}
    
    // convert the type race of characters to an emoji for the label button
    private func convertRace(charac:Character) -> String {
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
    private func disableAllButton() {
        activeButton(button: player1Charac1Button, active: false, alpha: 0.2)
        activeButton(button: player1Charac2Button, active: false, alpha: 0.2)
        activeButton(button: player1Charac3Button, active: false, alpha: 0.2)
        activeButton(button: player2Charac1Button, active: false, alpha: 0.2)
        activeButton(button: player2Charac2Button, active: false, alpha: 0.2)
        activeButton(button: player2Charac3Button, active: false, alpha: 0.2)
    }
    
    // function for enable/disable a button
    private func activeButton(button:UIButton, active:Bool, alpha:Double){
        button.isEnabled = active
        button.alpha = CGFloat(alpha)
    }
    
    // set alpha 1 to the button of the currrent character
    private func activateCharacterButton(character:Character){
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
    
    private func characterIsDead(character:Character){
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
    
    private func letsBounce(button:UIButton) {
        button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: .allowUserInteraction, animations: {button.transform = CGAffineTransform.identity}, completion: nil)
    }
    
    private func chooseCharacterOrTarget(choice:Character){
        if currentAction == "" {
            currentCharacter = choice
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
    
    func turn(){
        if currentPlayerIndex == currentPlayerArray.count {
            currentPlayerIndex = 0
        }
        currentPlayer = currentPlayerArray[currentPlayerIndex]
        disableAllButton()
        activeButton(button: cancelButton, active: false, alpha: 0.2)
        activeButton(button: attackButton, active: false, alpha: 0.2)
        activeButton(button: healButton, active: false, alpha: 0.2)
        // set the current player
        currentPlayer = currentPlayerArray[currentPlayerIndex]
        if currentPlayer?.characters[0].canPlay == false && currentPlayer?.characters[1].canPlay == false && currentPlayer?.characters[2].canPlay == false {
            currentPlayerIndex += 1
            if currentPlayerArray.count == currentPlayerIndex {
                currentPlayerIndex = 0
            }
        turn()
        }
        for character in currentPlayer!.characters {
            if character.race.health > 0 && character.canPlay == true {
                activateCharacterButton(character: character)
            }
        }
        // show who is the current character by showing his name
        if currentCharacter == nil {
            currentCharacterLabel.text = "\(currentPlayer!.name) choose a character"
        }
        // show to the user the damage and heal his player can make"
        if currentCharacter != nil {
            activeButton(button: attackButton, active: true, alpha: 1)
            if (currentCharacter?.race.weapon.heal)! > 0 {
                activeButton(button: healButton, active: true, alpha: 1)
            }
            currentCharacterHealLabel.text = "+ \(currentCharacter!.race.weapon.heal)"
            currentCharacterAttackLabel.text = " - \(currentCharacter!.race.weapon.damage)"
        } else {
            currentCharacterHealLabel.text = "-"
            currentCharacterAttackLabel.text = "-"
        }
        if currentAction != "" && currentTarget != nil {
            doAction()
        }
    }
    
    // function for refresh the health of all characters
    func refresh(){
    player1Charac1HPLabel.text = "\(player1.characters[0].race.health)"
    player1Charac2HPLabel.text = "\(player1.characters[1].race.health)"
    player1Charac3HPLabel.text = "\(player1.characters[2].race.health)"
    player2Charac1HPLabel.text = "\(player2.characters[0].race.health)"
    player2Charac2HPLabel.text = "\(player2.characters[1].race.health)"
    player2Charac3HPLabel.text = "\(player2.characters[2].race.health)"
    currentAction = ""
    currentTarget = nil
    currentCharacter = nil
    for i in 0...2 {
        characterIsDead(character: player1.characters[i])
        characterIsDead(character: player2.characters[i])
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
        // if it's one character of the player 1, enable player2 character's button but if heath is > 0 else can't target a dead character
        if currentCharacter == player1.characters[0] || currentCharacter == player1.characters[1] || currentCharacter == player1.characters[2]{
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
        if currentCharacter == player2.characters[0] || currentCharacter == player2.characters[1] || currentCharacter == player2.characters[2]{
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
    
//    func alert(){
//        let randomNumber: Int = .random(in: 0...2)
//        var randomWeapon:Weapon?
//        if currentCharacter?.race.type == "elf" {
//            randomWeapon = arrayBow[randomNumber]
//        }
//        if currentCharacter?.race.type == "dwarf" {
//            randomWeapon = arrayAxe[randomNumber]
//        }
//        if currentCharacter?.race.type == "wizzard" {
//            randomWeapon = arrayStick[randomNumber]
//        }
//        if currentCharacter?.race.type == "human" {
//            randomWeapon = arraySword[randomNumber]
//        }
//        let message = "A treasure chest appears with a \(currentCharacter!.race.weapon.name) inside"
//        let alertController = UIAlertController(title: "🎁", message: "\(message)\ndamage : \(randomWeapon!.damage) heal : \(randomWeapon!.heal)", preferredStyle: .alert)
//        let equipAction = UIAlertAction(title: "Equip", style: .default, handler: { action in
//            self.currentCharacter!.race.weapon = randomWeapon!
//            self.action()
//        })
//        let dontEquipAction = UIAlertAction(title: "Don't equip", style: .default, handler: { action in
//            self.action()
//        })
//        alertController.addAction(equipAction)
//        alertController.addAction(dontEquipAction)
//        self.present(alertController, animated: true)
//        }
    
    
    // perform current action on current target
    func doAction() {
//        let randomNumber: Int = .random(in: 0...3)
//        if randomNumber == 2 {
//            alert()
//        } else {
            action()
//        }
    }
    
    private func action(){
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
    isGameOver()
    if game.state == .isOver {
        performSegue(withIdentifier: "winView", sender: Any?.self)
    } else {
    currentCharacter!.canPlay = false
    currentPlayerIndex += 1
    checkTurn()
    disableAllButton()
    // change the index to go to the next character of the array
    // if the last character play, go back to the first and increase a turn.
    if currentPlayerArray.count == currentPlayerIndex {
        currentPlayerIndex = 0
    }
    currentPlayer = currentPlayerArray[currentPlayerIndex]
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
        if currentCharacter == player1.characters[0]{
            if (currentCharacter?.race.health)! < (currentCharacter?.race.healthMax)! {
            activeButton(button: player1Charac1Button, active: true, alpha: 1)
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
                activeButton(button: player1Charac2Button, active: true, alpha: 1)
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
                activeButton(button: player1Charac3Button, active: true, alpha: 1)
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
                activeButton(button: player2Charac1Button, active: true, alpha: 1)
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
                activeButton(button: player2Charac2Button, active: true, alpha: 1)
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
            activeButton(button: player2Charac3Button, active: true, alpha: 1)
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
        letsBounce(button: cancelButton)
        currentAction = ""
        disableAllButton()
        activeButton(button: attackButton, active: true, alpha: 1)
        for character in currentPlayer!.characters {
            if character.race.health > 0 {
                activateCharacterButton(character: character)
            }
        }
        if (currentCharacter?.race.weapon.heal)! > 0 {
            activeButton(button: healButton, active: true, alpha: 1)
        }
        activeButton(button: cancelButton, active: false, alpha: 0.2)
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
