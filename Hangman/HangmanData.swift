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
    var chalkboard = UIImage(named: "Chalkboard")
    var smallChalkboard = UIImage(named: "Chalkboard")
    var playerWon = String()
    var leaderboardSingle = [String]()
    var leaderboardChallenge = [String]()
    
    // MARK: - Initializers
    
    private init() {}
    
}
