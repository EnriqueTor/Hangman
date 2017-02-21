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
    
    // General
    
    var chalkboard = UIImage(named: "Chalkboard")
    var smallChalkboard = UIImage(named: "ChalkboardBlackOption")
    var user = User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
    
    
    // Play
    
    var arrayOfWords: [String] = []
    var game = Game(id: "", player: "", type: "", date: "", result: "", score: "", lives: "")
    var playerWon = String()

    // Leaderboard
    
    var leaderboardSingle = [String]()
    var leaderboardChallenge = [String]()
    var leaderboardMultiplayer = [String]()
    
    // Multiplayer
    
    var groupGame = GroupGame(id: "", date: "", status: "", title: "", rounds: "", player1Id: "", player1Name: "", player1Pic: "", player1Rounds: "", player1Points: "", player2Id: "", player2Name: "", player2Pic: "", player2Rounds: "", player2Points: "", player3Id: "", player3Name: "", player3Pic: "", player3Rounds: "", player3Points: "", player4Id: "", player4Name: "", player4Pic: "", player4Rounds: "", player4Points: "")
    
    var inviteSelected = 1
    var gameSelected = ""
    var gameRounds = "?"
    
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
