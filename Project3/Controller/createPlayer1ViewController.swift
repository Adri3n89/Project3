//
//  createPlayer1ViewController.swift
//  Project3
//
//  Created by Adrien PEREA on 30/03/2021.
//

import UIKit

class createPlayer1ViewController: UIViewController {
// creation des outlets
    @IBOutlet weak var namePlayer1TF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nameCharacterTF: UITextField!
    @IBOutlet weak var createPlayerButton: UIButton!
    @IBOutlet weak var createCharacterButton: UIButton!
    
// creation de la fonction pour ajouter un personnage au tableau des personnages
    
    var characRace:Race?
    var characRaceString:String?
    
// creation fonction pour les messages d'alerte
    func alert(message:String){
        let message = message
        let alertController = UIAlertController(title: "Wait a minute", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func createCharacter(_ sender: Any) {
        verif()
        let newCharacter = Character(name: nameCharacterTF.text!, race: characRace!)
        if nameCharacterTF.text!.count < 3 {
            alert(message: "Your Character's name must have 3 caracters mini")
        }
        else if player1.characters.count == 0 {
            player1.characters.append(newCharacter)
            nameCharacterTF.text = ""
            // actualisation de la tableView pour voir le personnage créé
            tableView.reloadData()
        }
        else if player1.characters.count == 1  {
            if player1.characters[0].name == newCharacter.name {
                    alert(message: "You can't have 2 characters with the same name")
            }else {
            player1.characters.append(newCharacter)
            nameCharacterTF.text = ""
            // actualisation de la tableView pour voir le personnage créé
            tableView.reloadData()
        }
        }
        else if player1.characters.count == 2 {
            if player1.characters[0].name == newCharacter.name {
                alert(message: "You can't have 2 characters with the same name")
            }
            else if player1.characters[1].name == newCharacter.name {
                alert(message: "You can't have 2 characters with the same name")
            }
            else {
                player1.characters.append(newCharacter)
                nameCharacterTF.text = ""
                // actualisation de la tableView pour voir le personnage créé
                tableView.reloadData()
            }}
        else if player1.characters.count > 2 {
    alert(message: "You can only have 3 characters, delete one before create an other")
}
}
    

// creation de la fonction pour ajouter un joueur
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPlayer2" {
            _ = segue.destination as! createPlayer2ViewController
        }
        }
    
    
    @IBAction func createPlayer(_ sender: Any) {
        player1.name = namePlayer1TF.text!
        if player1.characters.count < 3 {
            alert(message: "Your player must have 3 characters in his team")
        }
        performSegue(withIdentifier: "goToPlayer2", sender: Any?.self)
    }
    
// attribuer la race par rapport a un string
    func verif(){
        if characRaceString == "elf" {
            characRace = elf
        }
        if characRaceString == "human" {
            characRace = human
        }
        if characRaceString == "wizzard" {
            characRace = wizzard
        }
        if characRaceString == "dwarf" {
            characRace = dwarf
        }
    }
    

// fonction pour initialiser les parametres des vues
    func viewSetup(){
        namePlayer1TF.delegate = self
        nameCharacterTF.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        characRace = elf
}
}

// refermer le clavier après la touche retour
extension createPlayer1ViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        player1.name = namePlayer1TF.text!
        if namePlayer1TF.text!.count < 3 {
            alert(message: "Your Player's name must have 3 caracters mini")
        }
        view.endEditing(true)
        return true
    }
}
// parametrage de la tableView
extension createPlayer1ViewController : UITableViewDataSource, UITableViewDelegate {
    // nombre de rangées du tableview egale au count du tableau de personnages
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player1.characters.count
    }
    
    // renvoi des données dans les labels de la cell de la tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "character", for: indexPath) as! CharacterTableViewCell
        cell.characterName.text = player1.characters[indexPath.row].name
        cell.characterRace.text = player1.characters[indexPath.row].race.type
        return cell
    }
    
    // ajout de d'un swipe dans la tableView pour supprimer un personnage a son index dans la tableview et du tableau de personnage
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") {(action, view, completionHandler) in
            player1.characters.remove(at: indexPath.row)
            tableView.reloadData()
    }
    return UISwipeActionsConfiguration(actions: [action])
}
    
}

// parametrage du pickerView
extension createPlayer1ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    // initialisation du nombre de colonnes
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // initiliation du nombre de rangées par rapport au nombre de race
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return race.count
    }
    
    //initialisation  du titre des rangées du pickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return race[row]
    }
    
    // renvoi de la race selectionnée au personnage
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        characRaceString = race[row]
    }
}
