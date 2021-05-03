//
//  WinViewViewController.swift
//  Project3
//
//  Created by Adrien PEREA on 08/04/2021.
//

import UIKit

class WinViewViewController: UIViewController {

    @IBOutlet weak var victoryLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // show the winner, the number of turns and the PV left to the winner character's
        victoryLabel.text = victoryString
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true

    }
}
