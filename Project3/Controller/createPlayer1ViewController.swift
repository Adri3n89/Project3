//
//  createPlayer1ViewController.swift
//  Project3
//
//  Created by Adrien PEREA on 30/03/2021.
//

import UIKit

class CreatePlayer1ViewController: CreatePlayerViewController {
// MARK: - @IBOUTLET
    @IBOutlet weak var namePlayer1TF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nameCharacterTF: UITextField!
    @IBOutlet weak var createPlayerButton: UIButton!
    @IBOutlet weak var createCharacterButton: UIButton!

// MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        characRaceSelected = characRace[0]
    }
// MARK: - @IBACTION
// create character and add it to the player1 array if conditions are respected
// swiftlint:disable:next cyclomatic_complexity
    @IBAction func createCharacter(_ sender: Any) {
//       createNewCharacter()
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
        // check if the character's name have 3 letters
        if nameCharacterTF.text!.count < 3 {
            alert(message: character3Letters)
        // if it's the first character, no other check needed
        } else if player1.characters.count == 0 {
            player1.characters.append(newCharacter)
            nameCharacterTF.text = ""
            // refresh the tableview
            tableView.reloadData()
        // if there is 1 character in the array, check the name
        } else if player1.characters.count == 1 {
            if player1.characters[0].name.capitalized == newCharacter.name.capitalized {
                alert(message: character2Names)
            } else {
                player1.characters.append(newCharacter)
                nameCharacterTF.text = ""
                // refresh the tableview
                tableView.reloadData()
            }
        // if there is 2 character in the array, check the 2 names
        } else if player1.characters.count == 2 {
            if player1.characters[0].name.capitalized == newCharacter.name.capitalized {
                alert(message: character2Names)
            } else if player1.characters[1].name.capitalized == newCharacter.name.capitalized {
                alert(message: character2Names)
            } else {
                player1.characters.append(newCharacter)
                nameCharacterTF.text = ""
                // refresh the tableview
                tableView.reloadData()
                }
        } else if player1.characters.count > 2 {
            alert(message: character3Max)
        }
    }

// create the player 1 if conditions are respected
    @IBAction func createPlayer(_ sender: Any) {
        player1.name = namePlayer1TF.text!
        if player1.characters.count < 3 {
            alert(message: characterTeamMini)
        } else if player1.name.count < 3 {
            alert(message: player3Letters)
        } else {
            performSegue(withIdentifier: "goToPlayer2", sender: Any?.self)
        }
    }

// MARK: - PRIVATE FUNC
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
        namePlayer1TF.delegate = self
        nameCharacterTF.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        pickerView.dataSource = self
        pickerView.delegate = self
    }
}

// MARK: - EXTENSIONS
// close the keyboard when return or alert if player name < 3 letters
extension CreatePlayer1ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        player1.name = namePlayer1TF.text!
        if namePlayer1TF.text!.count < 3 {
            alert(message: characterTeamMini)
        }
        view.endEditing(true)
        return true
    }
}

// setup TableView
extension CreatePlayer1ViewController: UITableViewDataSource, UITableViewDelegate {
// number of row equal to number of characters of player 1
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player1.characters.count
    }

// return to the cell the name of the characters and the race
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable:next force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "character", for: indexPath) as! CharacterTableViewCell
        cell.characterName.text = player1.characters[indexPath.row].name
        cell.characterRace.text = player1.characters[indexPath.row].race.type.rawValue
        return cell
    }

// add a swipe to delete a character in the tableView
// swiftlint:disable:next line_length
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") {(_, _, _) in
            player1.characters.remove(at: indexPath.row)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

// setup PickerView
extension CreatePlayer1ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
