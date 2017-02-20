//
//  HangmanData.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/16/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import Foundation
import UIKit

class HangmanData {
    
    // MARK: - Properties
    
    static let sharedInstance = HangmanData()
    
    var arrayOfWords: [String] = []
    
    var user = User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
    
    var game = Game(id: "", player: "", type: "", date: "", result: "", score: "", lives: "")
    
//    var groupGame = GroupGame(id: "", player1: "", player2: "", player3: "", player4: "", date: "", status: "", title: "", words: "")
    var gameSelected = ""
    
    var chalkboard = UIImage(named: "Chalkboard")
    var smallChalkboard = UIImage(named: "ChalkboardBlackOption")
    var playerWon = String()
    var leaderboardSingle = [String]()
    var leaderboardChallenge = [String]()
    
    var inviteSelected = 1
    var user2: User = User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
    var user3: User = User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
    var user4: User = User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
    var user2Change = false
    var user3Change = false
    var user4Change = false
    var multiplayerAmountOfPlayers = 1
    var multiplayerAmountOfWords = "0"
    
    // MARK: - Initializers
    
    private init() {}
    
}
