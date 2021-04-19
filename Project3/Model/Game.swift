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

var game = Game()

func checkHealth(_ player: Player, _ index: Int) -> Int {
    return player.characters[index].race.health
}

func isGameOver() {
    if checkHealth(player1, 0) == 0 && checkHealth(player1, 1) == 0 && checkHealth(player1, 2) == 0 {
        game.winner = player2
        game.state = .isOver
    }
    if checkHealth(player2, 0) == 0 && checkHealth(player2, 1) == 0 && checkHealth(player2, 0) == 0 {
        game.state = .isOver
        game.winner = player1
}
}
