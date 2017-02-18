//
//  GameViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/15/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class GameViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var livesLabel: UILabel!
    @IBOutlet weak var secretWordLabel: UILabel!
    @IBOutlet var keyboardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - Variables
    
    let store = HangmanData.sharedInstance
    let database = FIRDatabase.database().reference()
    var lives = 6
    var secretWord = ""
    var wordCharacter = 0
    var hiddenWord = ""
    var points = 10
    var typeOfGame = String()
    var player: User!
    
    // MARK: - Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlayerData()
        isKeyboardEnabled(status: false)
        
        newGame()
        
        background.image = store.chalkboard
        
    }
    
    func loadPlayerData() {
        
        database.child("users").child(self.store.user.id).observe(.value, with: { (snapshot) in
            
            self.store.user = User(snapshot: snapshot)
            
            print(self.store.user)
            
            //            let data = snapshot.value as? [String:Any]
            //
            //            print(data)
            //
            //            let loggedUser = User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
            //
            //            self.store.user = loggedUser.deserialize(data!)
            
            //            self.store.user = User(snapshot: snapshot.value as! FIRDataSnapshot)
            
            
            
            
        })
    }
    
    // MARK: - Actions
    
    @IBAction func letterPressed(_ sender: UIButton) {
        
        var buttonTitle = sender.titleLabel?.text
        
        if secretWord.range(of: buttonTitle!) != nil {
            play(isCorrect: true, button: sender)
        }
        else {
            play(isCorrect: false, button: sender)
        }
    }
    
    // MARK: - Methods
    
    
    func newGame() {
        
        lives = 6
        livesLabel?.text = "\(lives)"
        
        secretWord = ""
        hiddenWord = ""
        wordCharacter = 0
        
        points = 10
        scoreLabel.text = "+\(points)"
        
        for button in keyboardButtons {
            button.setTitleColor(.white, for: .normal)
        }
        
        letsPlay()
        
    }
    
    func letsPlay() {
        
        let allWords = Int(arc4random_uniform(UInt32(store.arrayOfWords.count)))
        
        secretWord = store.arrayOfWords[allWords - 1].uppercased()
        
        for _ in self.secretWord.characters {
            
            self.hiddenWord.append("_")
            
        }
        
        self.secretWordLabel.text = self.hiddenWord
        self.isKeyboardEnabled(status: true)
        
    }
    
    
    func isKeyboardEnabled(status: Bool) {
        
        for button in keyboardButtons {
            
            button.isEnabled = status
        }
    }
    
    func play(isCorrect: Bool, button: UIButton) {
        
        if isCorrect == true {
            
            button.isEnabled = false
            button.setTitleColor(Constants.Colors.chalkGreen, for: .normal)
            
            let buttonChar = button.titleLabel?.text?.characters.first!
            
            for (index, char) in secretWord.characters.enumerated() {
                
                if buttonChar == char {
                    
                    var newWord = ""
                    
                    for (newIndex, newChar) in hiddenWord.characters.enumerated() {
                        
                        if newIndex == index {
                            
                            newWord.append(char)
                            
                        } else {
                            
                            newWord.append(newChar)
                        }
                        
                    }
                    
                    hiddenWord = newWord
                    secretWordLabel.text = hiddenWord
                    
                    updateScore(guessedRight: true)
                }
            }
        }
        
        if isCorrect == false {
            
            button.isEnabled = false
            button.setTitleColor(Constants.Colors.chalkRed, for: .normal)
            updateScore(guessedRight: false)
        }
    }
    
    func updateScore(guessedRight: Bool) {
        
        if guessedRight == true {
            points = points + 1
            winOrLose(test: "WON")
        }
        
        if guessedRight == false {
            lives = lives - 1
            livesLabel.text = "\(lives)"
            points = points - 1
            winOrLose(test: "LOST")
        }
        
        if points >= 0 {
            scoreLabel.text = "+\(points)"
            
            
        } else {
            scoreLabel.text = "\(points)"
        }
    }
    
    func winOrLose(test: String) {
        
        if test == "WON" {
            if secretWord == hiddenWord {
                gameEnded(result: "WON", pointsEarned: 10)
            }
        }
        
        if test == "LOST" {
            if lives < 0 {
                gameEnded(result: "LOST", pointsEarned: -10)
            }
        }
    }
    
    func gameEnded(result: String, pointsEarned: Int) {
        
        isKeyboardEnabled(status: false)
        store.playerWon = result
        points = points + pointsEarned
        
        let root = database.child("game").childByAutoId()
        let gameID = root.key
        
        let newGame = Game(id: gameID, player: store.user.id, type: "SINGLE", date: getDate(date: Date()), result: result, score: "\(points)", lives: "\(lives)")
        
        database.child("games").child(gameID).setValue(newGame.serialize())
        database.child("playedSingle").child(store.user.id).child(gameID).setValue(getDate(date: Date()))
        
        if self.store.user.scoreSingle == "" {
            
            self.store.user.scoreSingle = "\(0 + self.points)"
            
        } else {
            
            self.store.user.scoreSingle = "\(Int32(self.store.user.scoreSingle)! + self.points)"
        }
        
        self.database.child("users").child(self.store.user.id).child("scoreSingle").setValue(self.store.user.scoreSingle)
        self.database.child("leaderboardSingle").child(self.store.user.id).setValue(self.store.user.scoreSingle)
        performSegue(withIdentifier: "resultSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "resultSegue" {
            
            guard let dest = segue.destination as? ResultViewController else { return }
            
            if store.playerWon == "WON" {
                
                dest.gameResult = "YOU WON"
                dest.secretWord = secretWord
                dest.points = points
                
            }
            if store.playerWon == "LOST" {
                
                dest.gameResult = "YOU LOST"
                dest.secretWord = secretWord
                dest.points = points
            }
        }
    }
    
    func getDate(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date).uppercased()
    }
    
}


