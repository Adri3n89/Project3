//
//  Game.swift
//  Project3
//
//  Created by Adrien PEREA on 02/04/2021.
//

import Foundation

class Game {
    
    enum State{
        case isOngoing,isOver
    }
    var state:State = .isOngoing
    var totalTurn:Int = 1
    
    
}

var game = Game()

func isGameOver(){
if (player1.characters[0].race.health == 0 && player1.characters[1].race.health == 0 && player1.characters[2].race.health == 0) || (player2.characters[0].race.health == 0 && player2.characters[1].race.health == 0 && player2.characters[2].race.health == 0) {
    game.state = .isOver
}
}



