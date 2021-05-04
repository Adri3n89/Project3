//
//  Game.swift
//  Project3
//
//  Created by Adrien PEREA on 02/04/2021.
//

import Foundation

class Game {
    enum State {
        case isOngoing
        case isOver
    }
    var state: State = .isOngoing
    var totalTurn: Int = 1
    var winner: Player?
}
