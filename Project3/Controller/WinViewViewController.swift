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
        victoryLabel.text = """
Congratulation \(game.winner!.name.capitalized) you win the fight !
\(game.winner!.characters[0].name) have \(game.winner!.characters[0].race.health) pv left
\(game.winner!.characters[1].name) have \(game.winner!.characters[1].race.health) pv left
\(game.winner!.characters[2].name) have \(game.winner!.characters[2].race.health) pv left
you win in \(game.totalTurn) turns
"""
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }

    @IBAction func pushHomeButton(_ sender: Any) {
        let startController = self.storyboard?.instantiateViewController(identifier: "mainMenu")
        self.view.window?.rootViewController = startController
        player1.name = ""
        player2.name = ""
        player1.characters = []
        player2.characters = []
    }

    @IBAction func pushReplayButton(_ sender: Any) {
        performSegue(withIdentifier: "fight", sender: Any?.self)
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
