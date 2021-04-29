//
//  createPlayer1ViewController.swift
//  Project3
//
//  Created by Adrien PEREA on 30/03/2021.
//

import UIKit

class CreatePlayerViewController: UIViewController {
// MARK: - @IBOUTLETS
    @IBOutlet weak var namePlayerTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nameCharacterTF: UITextField!
    @IBOutlet weak var createPlayerButton: UIButton!
    @IBOutlet weak var createCharacterButton: UIButton!
    @IBOutlet weak var createPlayerText: UILabel!

// MARK: - VARIABLES
    var isPlayer2: Bool = false

// MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        characRaceSelected = characRace[0]
    }
// MARK: - @IBACTIONS
// create character and add it to the player array if conditions are respected
    @IBAction func createCharacter(_ sender: Any) {
        var race: Race?
        switch characRaceSelected {
        case "Human":
            race = Human()
        case "Dwarf":
            race = Dwarf()
        case "Wizzard":
            race = Wizzard()
        default:
            race = Elf()
        }
        let newCharacter = Character(name: nameCharacterTF.text!, race: race!)
        isPlayer2 ? createCharacterPlayer2(character: newCharacter) : createCharacterPlayer1(character: newCharacter)
    }

// create the player 1 if conditions are respected
    @IBAction func createPlayer(_ sender: Any) {
        isPlayer2 ? createPlayer2() : createPlayer1()
    }

// MARK: - PRIVATES FUNCTIONS

    private func createCharacterPlayer2(character: Character) {
        var sameName = 0
        // verification si le nom du nouveau personnage a minimum 3 caracteres
        if nameCharacterTF.text!.count < 3 {
            alert(message: character3Letters)
        // si c'est le premier perso, verification si il a deja des personnages avec le meme nom chez le player1
        } else if player2.characters.count == 0 {
            for index in 0...player1.characters.count-1 where checkName(character, player1, index) {
                sameName += 1
            }
            // si oui faire l'alerte
            if sameName > 0 {
                alert(message: characterP2P1)
                sameName = 0
            // sinon ajouter le personnage au tableau du joueur 2
            } else {
                player2.characters.append(character)
                nameCharacterTF.text = ""
                tableView.reloadData()
            }
        // si il y a deja 3 perso, alerter le joueur qu'il ne peut pas en avoir plus
        } else if player2.characters.count > 2 {
            alert(message: character3Max)
        // sinon verifier parmis les premiers perso du player2
        } else {
            for index in 0...player2.characters.count-1 where checkName(character, player2, index) {
                sameName += 1
            }
            if sameName > 0 {
                alert(message: character2Names)
                sameName = 0
            // puis si il n'a pas de perso identique, verifier chez le player1
            } else {
                for index in 0...player1.characters.count-1 where checkName(character, player1, index) {
                    sameName += 1
                }
                if sameName > 0 {
                    alert(message: characterP2P1)
                    sameName = 0
                } else {
                    // si aucun identique, ajouter le personnage au tableau du joueur 2
                    player2.characters.append(character)
                    nameCharacterTF.text = ""
                    tableView.reloadData()
                }
            }
        }
    }

    private func createCharacterPlayer1(character: Character) {
        // check if the character's name have 3 letters
        if nameCharacterTF.text!.count < 3 {
            alert(message: character3Letters)
        // if it's the first character, no other check needed
        } else if player1.characters.count == 0 {
            player1.characters.append(character)
            nameCharacterTF.text = ""
            // refresh the tableview
            tableView.reloadData()
        // if there is 1 character in the array, check the name
        } else if player1.characters.count == 1 {
            if player1.characters[0].name.capitalized == character.name.capitalized {
                alert(message: character2Names)
            } else {
                player1.characters.append(character)
                nameCharacterTF.text = ""
                // refresh the tableview
                tableView.reloadData()
            }
        // if there is 2 character in the array, check the 2 names
        } else if player1.characters.count == 2 {
            if player1.characters[0].name.capitalized == character.name.capitalized {
                alert(message: character2Names)
            } else if player1.characters[1].name.capitalized == character.name.capitalized {
                alert(message: character2Names)
            } else {
                player1.characters.append(character)
                nameCharacterTF.text = ""
                // refresh the tableview
                tableView.reloadData()
                }
        } else if player1.characters.count > 2 {
            alert(message: character3Max)
        }
    }

    private func createPlayer1() {
        player1.name = namePlayerTF.text!
        if player1.characters.count < 3 {
            alert(message: characterTeamMini)
        } else if player1.name.count < 3 {
            alert(message: player3Letters)
        } else {
            changePlayer()
        }
    }

    private func createPlayer2() {
        player2.name = namePlayerTF.text!
        if player2.characters.count < 3 {
            alert(message: characterTeamMini)
        } else if player2.name.count < 3 {
            alert(message: player3Letters)
        } else if player2.name.capitalized == player1.name.capitalized {
            alert(message: player2Names)
        } else {
            performSegue(withIdentifier: "goToFight", sender: Any?.self)
        }
    }

    private func changePlayer() {
        createPlayerText.text = createPlayer2String
        isPlayer2 = true
        tableView.reloadData()
        namePlayerTF.text = ""
        nameCharacterTF.text = ""
    }

// pop an alert
    private func alert(message: String) {
        let alertController = UIAlertController(title: titleAlert, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okString, style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

// check the newCharacter name
    private func checkName(_ newCharac: Character, _ player: Player, _ index: Int) -> Bool {
        return newCharac.name.capitalized == player.characters[index].name.capitalized
    }

// setup TF, tableView and pickerView
    private func viewSetup() {
        namePlayerTF.delegate = self
        nameCharacterTF.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        pickerView.dataSource = self
        pickerView.delegate = self
    }
}

// MARK: - EXTENSIONS
// close the keyboard when return or alert if player name < 3 letters
extension CreatePlayerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isPlayer2 {
            player2.name = namePlayerTF.text!
        } else {
            player1.name = namePlayerTF.text!
        }
        if namePlayerTF.text!.count < 3 {
            alert(message: characterTeamMini)
        }
        view.endEditing(true)
        return true
    }
}

// setup TableView
extension CreatePlayerViewController: UITableViewDataSource, UITableViewDelegate {
// number of row equal to number of characters of player 1
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isPlayer2 {
            return player2.characters.count
        } else {
            return player1.characters.count
        }
    }

    func tableviewCell(cell: CharacterTableViewCell, player: Player, indexPath: IndexPath) {
        cell.characterName.text = player.characters[indexPath.row].name
        cell.characterRace.text = player.characters[indexPath.row].race.type.rawValue
    }

// return to the cell the name of the characters and the race
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "character", for: indexPath) as! CharacterTableViewCell
        var tableViewPlayer: Player
        isPlayer2 ? (tableViewPlayer = player2) : (tableViewPlayer = player1)
        tableviewCell(cell: cell, player: tableViewPlayer, indexPath: indexPath)
        return cell
    }

// add a swipe to delete a character in the tableView
// swiftlint:disable:next line_length
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") {(_, _, _) in
            if self.isPlayer2 {
                player2.characters.remove(at: indexPath.row)
            } else {
                player1.characters.remove(at: indexPath.row)
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

// setup PickerView
extension CreatePlayerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // init the number of colomn
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // init number of row equal to number of race
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return characRace.count
    }

// init title of row with the Race RawValue
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return characRace[row]
    }

// add the race of row to a variable to assign it to the new character
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        characRaceSelected = characRace[row]
    }
}
