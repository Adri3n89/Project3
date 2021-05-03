//
//  CreatePlayerManager.swift
//  Project3
//
//  Created by Adrien PEREA on 30/04/2021.
// swiftlint:disable line_length

import Foundation
import UIKit

var race: Race?
var characRaceSelected: String?
let characRace: [String] = ["Elf", "Human", "Wizzard", "Dwarf"]
var isPlayer2: Bool = false

// pop an alert
func alert(message: String, view: UIViewController) {
    let alertController = UIAlertController(title: titleAlert, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: okString, style: .default, handler: nil)
    alertController.addAction(okAction)
    view.present(alertController, animated: true, completion: nil)
}

// check the newCharacter name
private func checkName(_ newCharac: Character, _ player: Player, _ index: Int) -> Bool {
    return newCharac.name.capitalized == player.characters[index].name.capitalized
}

func createCharacterPlayer2(character: Character, textField: UITextField, tableView: UITableView, view: UIViewController) {
    var sameName = 0
    // check if the character's name have 3 letters
    if textField.text!.count < 3 {
        alert(message: character3Letters, view: view)
        // if it's the first character, only check with first player characters
    } else if player2.characters.count == 0 {
        for index in 0...player1.characters.count-1 where checkName(character, player1, index) {
            sameName += 1
        }
        if sameName > 0 {
            alert(message: characterP2P1, view: view)
            sameName = 0
        } else {
            player2.characters.append(character)
            textField.text = ""
            tableView.reloadData()
        }
    // alert if player want create a 4th character
    } else if player2.characters.count > 2 {
        alert(message: character3Max, view: view)
    // check with the player 2 characters
    } else {
        for index in 0...player2.characters.count-1 where checkName(character, player2, index) {
            sameName += 1
        }
        if sameName > 0 {
            alert(message: character2Names, view: view)
            sameName = 0
        // check with the player 1 characters
        } else {
            for index in 0...player1.characters.count-1 where checkName(character, player1, index) {
                sameName += 1
            }
            if sameName > 0 {
                alert(message: characterP2P1, view: view)
                sameName = 0
            } else {
                player2.characters.append(character)
                textField.text = ""
                tableView.reloadData()
            }
        }
    }
}

func createCharacterPlayer1(character: Character, textField: UITextField, tableView: UITableView, view: UIViewController) {
    var sameName = 0
    // check if the character's name have 3 letters
    if textField.text!.count < 3 {
        alert(message: character3Letters, view: view)
    // if it's the first character, no other check needed
    } else if player1.characters.count == 0 {
        player1.characters.append(character)
        textField.text = ""
        // refresh the tableview
        tableView.reloadData()
    // alert if player want create a 4th character
    } else if player1.characters.count > 2 {
        alert(message: character3Max, view: view)
    // check with the firsts characters
    } else {
        for index in 0...player1.characters.count-1 where checkName(character, player1, index) {
            sameName += 1
        }
        if sameName > 0 {
            alert(message: character2Names, view: view)
            sameName = 0
        } else {
            player1.characters.append(character)
            textField.text = ""
            tableView.reloadData()
        }
    }
}

func createPlayer1(view: UIViewController, textFieldPlayer: UITextField, labelPlayer: UILabel, textFieldCharacter: UITextField, tableView: UITableView) {
    player1.name = textFieldPlayer.text!
    if player1.characters.count < 3 {
        alert(message: characterTeamMini, view: view)
    } else if player1.name.count < 3 {
        alert(message: player3Letters, view: view)
    } else {
        labelPlayer.text = createPlayer2String
        isPlayer2 = true
        tableView.reloadData()
        textFieldPlayer.text = ""
        textFieldCharacter.text = ""
    }
}

func createPlayer2(view: UIViewController, textField: UITextField) {
    player2.name = textField.text!
    if player2.characters.count < 3 {
        alert(message: characterTeamMini, view: view)
    } else if player2.name.count < 3 {
        alert(message: player3Letters, view: view)
    } else if player2.name.capitalized == player1.name.capitalized {
        alert(message: player2Names, view: view)
    } else {
        view.performSegue(withIdentifier: "goToFight", sender: Any?.self)
    }
}
