//
//  WinViewViewController.swift
//  Project3
//
//  Created by Adrien PEREA on 08/04/2021.
//

import UIKit

class WinViewViewController: UIViewController {

    @IBOutlet weak var victoryLabel: UILabel!
    var game: Game!

    override func viewDidLoad() {
        let victoryString = """
     Congratulations \(game.winner!.name) you win the fight in \(game.totalTurn) turns!
     \(game.winner!.characters[0].name) have \(game.winner!.characters[0].race.health) pv left
     \(game.winner!.characters[1].name) have \(game.winner!.characters[1].race.health) pv left
     \(game.winner!.characters[2].name) have \(game.winner!.characters[2].race.health) pv left
     """
        super.viewDidLoad()
        // show the winner, the number of turns and the PV left to the winner character's
        victoryLabel.text = victoryString
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
    }
}
