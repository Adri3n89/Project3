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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
        player1NameLabel.text = player1.name
        player1Charac1HPLabel.text = String(player1.characters[0].race.health)
        player1Charac1NameLabel.text = player1.characters[0].name
        player1Charac1Button.titleLabel?.text = convertRace(charac: player1.characters[0])
        print(player1Charac1Button.titleLabel!.text!)
        player1Charac2HPLabel.text = String(player1.characters[1].race.health)
        player1Charac2NameLabel.text = player1.characters[1].name
        player1Charac3HPLabel.text = String(player1.characters[2].race.health)
        player1Charac3NameLabel.text = player1.characters[2].name
        player2NameLabel.text = player2.name
        player2Charac1HPLabel.text = String(player2.characters[0].race.health)
        player2Charac1NameLabel.text = player2.characters[0].name
        player2Charac2HPLabel.text = String(player2.characters[1].race.health)
        player2Charac2NameLabel.text = player2.characters[1].name
        player2Charac3HPLabel.text = String(player2.characters[2].race.health)
        player2Charac3NameLabel.text = player2.characters[2].name
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
