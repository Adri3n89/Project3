//
//  createPlayer2ViewController.swift
//  Project3
//
//  Created by Adrien PEREA on 31/03/2021.
//

import UIKit

class CreatePlayer2ViewController: UIViewController {
// creation des outlets
    @IBOutlet weak var namePlayer2TF: UITextField!
    @IBOutlet weak var nameCharacterTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var createCharacterButton: UIButton!
    @IBOutlet weak var createPlayerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        characRaceSelected = characRace[0]
}

// creation fonction pour les messages d'alerte
    private func alert(message: String) {
        let message = message
        let alertController = UIAlertController(title: titleAlert, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okString, style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }

    func checkName(_ newCharac: Character, _ player: Player, _ index: Int) -> Bool {
        return newCharac.name.capitalized == player.characters[index].name.capitalized
    }

// creation de la fonction pour ajouter un personnage au tableau des personnages
    @IBAction func createCharacter(_ sender: Any) {
        let newCharacter = Character(name: nameCharacterTF.text!, race: characRaceSelected!)
        var sameName = 0
        if nameCharacterTF.text!.count < 3 {
            alert(message: character3Letters)
        } else if player2.characters.count == 0 {
            for index in 0...player1.characters.count-1 where checkName(newCharacter, player1, index) {
                sameName += 1
            }
            if sameName > 0 {
                alert(message: characterP2P1)
                sameName = 0
            } else {
                player2.characters.append(newCharacter)
                nameCharacterTF.text = ""
                tableView.reloadData()
            }
        } else if player2.characters.count > 2 {
            alert(message: character3Max)
        } else {
            for index in 0...player2.characters.count-1 where checkName(newCharacter, player2, index) {
                sameName += 1
            }
            if sameName > 0 {
                alert(message: character2Names)
                sameName = 0
            } else {
                for index in 0...player1.characters.count-1 where checkName(newCharacter, player1, index) {
                    sameName += 1
                }
                if sameName > 0 {
                    alert(message: characterP2P1)
                    sameName = 0
                } else {
                    player2.characters.append(newCharacter)
                    nameCharacterTF.text = ""
                    tableView.reloadData()
                }
            }
        }
    }

// creation de la fonction pour ajouter un joueur
    @IBAction func createPlayer(_ sender: Any) {
        player2.name = namePlayer2TF.text!
        if player2.characters.count < 3 {
            alert(message: characterTeamMini)
        } else if player2.name.capitalized == player1.name.capitalized {
            alert(message: player2Names)
        } else if player2.name.count < 3 {
            alert(message: player3Letters)
        } else {
        performSegue(withIdentifier: "goToFight", sender: Any?.self)
        }
    }

// fonction pour initialiser les parametres des vues
    private func viewSetup() {
        namePlayer2TF.delegate = self
        nameCharacterTF.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        pickerView.dataSource = self
        pickerView.delegate = self
    }
}

// refermer le clavier après la touche retour
extension CreatePlayer2ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        player2.name = namePlayer2TF.text!
        if namePlayer2TF.text!.count < 3 {
            alert(message: player3Letters)
        }
        view.endEditing(true)
        return true
    }
}

// parametrage de la tableView
extension CreatePlayer2ViewController: UITableViewDataSource, UITableViewDelegate {
    // nombre de rangées du tableview egale au count du tableau de personnages
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player2.characters.count
    }

    // renvoi des données dans les labels de la cell de la tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // swiftlint:disable:next line_length force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: "character2", for: indexPath) as! Character2TableViewCell
        cell.characterName.text = player2.characters[indexPath.row].name
        cell.characterRace.text = player2.characters[indexPath.row].race.type
        return cell
    }

    // ajout de d'un swipe dans la tableView pour supprimer un personnage
    // swiftlint:disable:next line_length
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") {(_, _, _) in
            player2.characters.remove(at: indexPath.row)
            tableView.reloadData()
            }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

    // parametrage du pickerView
extension CreatePlayer2ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // initialisation du nombre de colonnes
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // initiliation du nombre de rangées par rapport au nombre de race
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return characRace.count
    }

    // initialisation  du titre des rangées du pickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return characRace[row].type
    }

    // renvoi de la race selectionnée au personnage
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        characRaceSelected = characRace[row]
    }
}
