//
//  StringManager.swift
//  Project3
//
//  Created by Adrien PEREA on 14/04/2021.
//

import Foundation

let titleAlert = "Wait a minute"
let okString = "Ok"
let character3Letters = "Your Character's name must have 3 letters mini"
let character2Names = "You can't have 2 characters with the same name"
let character3Max = "You can only have 3 characters, delete one before create an other"
let characterTeamMini = "Your player must have 3 characters in his team"
let player3Letters = "your Player's name must have 3 letters mini"
let player2Names = "Your player can't have the same playerOne's name"
let characterP2P1 = "You can't have the same character's name that Player 1"
let createPlayer2String = "Création du joueur 2"
let victoryString = """
Congratulations \(game.winner!.name.capitalized) you win the fight in \(game.totalTurn) turns!
\(game.winner!.characters[0].name) have \(game.winner!.characters[0].race.health) pv left
\(game.winner!.characters[1].name) have \(game.winner!.characters[1].race.health) pv left
\(game.winner!.characters[2].name) have \(game.winner!.characters[2].race.health) pv left
"""
