//
//  WinViewViewController.swift
//  Project3
//
//  Created by Adrien PEREA on 08/04/2021.
//

import UIKit

class WinViewViewController: UIViewController {

    @IBOutlet weak var victoryLabel: UILabel!
    @IBOutlet weak var replayButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        victoryLabel.text = "Congratulation \(game.winner!.name)\nyou win the fight !"
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHome" {
            _ = segue.destination as! UINavigationController
        }
        }
    
    @IBAction func pushHomeButton(_ sender: Any) {
        performSegue(withIdentifier: "goToHome", sender: Any?.self)
        // POUR LE BOUTON HOME : supprimer les variable des joueurs/character

    }
    
    @IBAction func pushReplayButton(_ sender: Any) {
        // POUR LE BOUTON REPLAY remettre la vie des perso a la vie max pour le bouton replay, remettre le total turn a 0 et remetre l'index sur 0
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
