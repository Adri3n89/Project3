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
    @IBOutlet weak var createCharacterButton: UIButton!
    
// creation de la fonction pour ajouter un personnage au tableau des personnages
    
    var characRace:Race?
    @IBAction func createCharacter(_ sender: Any) {
        let newCharacter = Character(name: nameCharacterTF.text!, race: characRace!)
        player1.characters.append(newCharacter)
        nameCharacterTF.text = ""
        // actualisation de la tableView pour voir le personnage créé
        tableView.reloadData()
        // autoriser la création de personnage jusqu'a 3, apres blocage du bouton
        if player1.characters.count < 3 {
            createCharacterButton.isUserInteractionEnabled = false
        } else {
            createCharacterButton.isUserInteractionEnabled = true
        }
    }
    
// creation de la fonction pour ajouter un joueur
    @IBAction func createPlayer(_ sender: Any) {
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
}
}

// refermer le clavier après la touche retour
extension createPlayer1ViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
        cell.characterRace.text = player1.characters[indexPath.row].race
        return cell
    }
    
    // ajout de d'un swipe dans la tableView pour supprimer un personnage a son index dans la tableview et du tableau de personnage
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Supprimer") {(action, view, completionHandler) in
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
    private func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> Race? {
        return race[row]
    }
    
    // renvoi de la race selectionnée au personnage
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        characRace = race[row]
    }
}
