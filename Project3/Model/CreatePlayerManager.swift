//
//  CreatePlayerManager.swift
//  Project3
//
//  Created by Adrien PEREA on 30/04/2021.
//

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
func checkName(_ newCharac: Character, _ player: Player, _ index: Int) -> Bool {
    return newCharac.name.capitalized == player.characters[index].name.capitalized
}
// swiftlint:disable:next line_length
func createCharacterPlayer2(character: Character, textField: UITextField, tableView: UITableView, view: UIViewController) {
    var sameName = 0
    // verification si le nom du nouveau personnage a minimum 3 caracteres
    if textField.text!.count < 3 {
        alert(message: character3Letters, view: view)
    // si c'est le premier perso, verification si il a deja des personnages avec le meme nom chez le player1
    } else if player2.characters.count == 0 {
        for index in 0...player1.characters.count-1 where checkName(character, player1, index) {
            sameName += 1
        }
        // si oui faire l'alerte
        if sameName > 0 {
            alert(message: characterP2P1, view: view)
            sameName = 0
        // sinon ajouter le personnage au tableau du joueur 2
        } else {
            player2.characters.append(character)
            textField.text = ""
            tableView.reloadData()
        }
    // si il y a deja 3 perso, alerter le joueur qu'il ne peut pas en avoir plus
    } else if player2.characters.count > 2 {
        alert(message: character3Max, view: view)
    // sinon verifier parmis les premiers perso du player2
    } else {
        for index in 0...player2.characters.count-1 where checkName(character, player2, index) {
            sameName += 1
        }
        if sameName > 0 {
            alert(message: character2Names, view: view)
            sameName = 0
        // puis si il n'a pas de perso identique, verifier chez le player1
        } else {
            for index in 0...player1.characters.count-1 where checkName(character, player1, index) {
                sameName += 1
            }
            if sameName > 0 {
                alert(message: characterP2P1, view: view)
                sameName = 0
            } else {
                // si aucun identique, ajouter le personnage au tableau du joueur 2
                player2.characters.append(character)
                textField.text = ""
                tableView.reloadData()
            }
        }
    }
}

// swiftlint:disable:next line_length
func createCharacterPlayer1(character: Character, textField: UITextField, tableView: UITableView, view: UIViewController) {
    // check if the character's name have 3 letters
    if textField.text!.count < 3 {
        alert(message: character3Letters, view: view)
    // if it's the first character, no other check needed
    } else if player1.characters.count == 0 {
        player1.characters.append(character)
        textField.text = ""
        // refresh the tableview
        tableView.reloadData()
    // if there is 1 character in the array, check the name
    } else if player1.characters.count == 1 {
        if player1.characters[0].name.capitalized == character.name.capitalized {
            alert(message: character2Names, view: view)
        } else {
            player1.characters.append(character)
            textField.text = ""
            // refresh the tableview
            tableView.reloadData()
        }
    // if there is 2 character in the array, check the 2 names
    } else if player1.characters.count == 2 {
        if player1.characters[0].name.capitalized == character.name.capitalized {
            alert(message: character2Names, view: view)
        } else if player1.characters[1].name.capitalized == character.name.capitalized {
            alert(message: character2Names, view: view)
        } else {
            player1.characters.append(character)
            textField.text = ""
            // refresh the tableview
            tableView.reloadData()
            }
    } else if player1.characters.count > 2 {
        alert(message: character3Max, view: view)
    }
}

// swiftlint:disable:next line_length
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
