//
//  createPlayer1ViewController.swift
//  Project3
//
//  Created by Adrien PEREA on 30/03/2021.
// swiftlint:disable line_length

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

    var playerManager: CreatePlayerManager!

// MARK: - VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        playerManager = CreatePlayerManager(delegate: self)
        playerManager.characRaceSelected = playerManager.characRace[0]
    }
// MARK: - @IBACTIONS
// create character and add it to the player array if conditions are respected
    @IBAction func createCharacter(_ sender: Any) {
        switch playerManager.characRaceSelected {
        case "Human":
            playerManager.race = Human()
        case "Dwarf":
            playerManager.race = Dwarf()
        case "Wizzard":
            playerManager.race = Wizzard()
        default:
            playerManager.race = Elf()
        }
        playerManager.isPlayer2 ? playerManager.createCharacterPlayer2(name: nameCharacterTF.text!, race: playerManager.race!) : playerManager.createCharacterPlayer1(name: nameCharacterTF.text!, race: playerManager.race!)
    }

// create the player if conditions are respected
    @IBAction func createPlayer(_ sender: Any) {
        playerManager.isPlayer2 ? playerManager.createPlayer2(name: namePlayerTF.text!) : playerManager.createPlayer1(name: namePlayerTF.text!)
    }

// MARK: - PRIVATES FUNCTIONS
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
        if playerManager.isPlayer2 {
            player2.name = namePlayerTF.text!
        } else {
            player1.name = namePlayerTF.text!
        }
        if namePlayerTF.text!.count < 3 {
            playerManager.delegate.createError(error: characterTeamMini)
        }
        view.endEditing(true)
        return true
    }
}

// setup TableView
extension CreatePlayerViewController: UITableViewDataSource, UITableViewDelegate {
// number of row equal to number of characters of player 1
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if playerManager.isPlayer2 {
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
        playerManager.isPlayer2 ? (tableViewPlayer = player2) : (tableViewPlayer = player1)
        tableviewCell(cell: cell, player: tableViewPlayer, indexPath: indexPath)
        return cell
    }

// add a swipe to delete a character in the tableView
// swiftlint:disable:next line_length
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") {(_, _, _) in
            if self.playerManager.isPlayer2 {
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
        return playerManager.characRace.count
    }

// init title of row with the Race RawValue
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return playerManager.characRace[row]
    }

// add the race of row to a variable to assign it to the new character
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        playerManager.characRaceSelected = playerManager.characRace[row]
    }
}

// protocol de CreatePlayerManager
extension CreatePlayerViewController: CreatePlayerManagerDelegate {

    func createPlayer2Success() {
        performSegue(withIdentifier: "goToFight", sender: Any?.self)
    }

    func createPlayer1Success() {
        createPlayerText.text = createPlayer2String
        tableView.reloadData()
        namePlayerTF.text = ""
        nameCharacterTF.text = ""
    }

    func createError(error: String) {
        let alertController = UIAlertController(title: titleAlert, message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okString, style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func createCharacterSuccess() {
        nameCharacterTF.text = ""
        // refresh the tableview
        tableView.reloadData()
    }

}
