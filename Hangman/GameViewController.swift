//
//  GameViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/15/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit
import Foundation

class GameViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var livesLabel: UILabel!
    @IBOutlet weak var secretWordLabel: UILabel!
    @IBOutlet var keyboardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    
    // MARK: - Variables
    
    let store = HangmanData.sharedInstance
    var lives = 6
    var secretWord = ""
    var wordCharacter = 0
    var hiddenWord = ""
    var points = 10
    
    // MARK: - Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isKeyboardEnabled(status: false)
        
        newGame()
        
        background.image = store.chalkboard
        
        print("HOLA!")
        
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        viewDidLoad()
////        newGame()
//    }
    
    // MARK: - Actions
    
    @IBAction func letterPressed(_ sender: UIButton) {
        
        var buttonTitle = sender.titleLabel?.text
        
        if secretWord.range(of: buttonTitle!) != nil {
            
            correct(button: sender)
            
        }
        else {
            
            miss(button: sender)
        }
        
    }
    
    // MARK: - Methods
    
    func correct(button: UIButton) {
        
        button.setTitleColor(.green, for: .normal)
        button.isEnabled = false
        
        var buttonChar = button.titleLabel?.text?.characters.first!
        
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
                points = points + 1
                updateScore()
                print(points)
                win()
            }
            
        }
        
    }
    
    func miss(button: UIButton) {
        
        button.setTitleColor(.red, for: .normal)
        button.isEnabled = false
        
        lives = lives - 1
        livesLabel.text = "\(lives)"
        
        points = points - 1
        updateScore()

        print(points)
        isHangman()
        
    }
    
    func isHangman() {
        
        if lives < 0 {
            
            store.gameResult = "lost"
            isKeyboardEnabled(status: false)
            points = points - 5
            updateScore()
            performSegue(withIdentifier: "resultSegue", sender: self)
        }
        
    }
    
    func win() {
        
        if secretWord == hiddenWord {
            
            isKeyboardEnabled(status: false)
            store.gameResult = "win"
            points = points + 5
            print(points)
            performSegue(withIdentifier: "resultSegue", sender: self)
            
            
            } else {
                
                "the word doesn't exist"
            }
            
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "resultSegue" {
            
            guard let dest = segue.destination as? ResultViewController else { return }
            
            if store.gameResult == "win" {
             
                dest.gameResult = "YOU WON"
                dest.secretWord = secretWord
                dest.points = points
                
            } else {
                
                dest.gameResult = "YOU LOST"
                dest.secretWord = secretWord
                dest.points = points
            }
            
            
        }
    }
    
    func isKeyboardEnabled(status: Bool) {
        
        for button in keyboardButtons {
            
            button.isEnabled = status
            
        }
        
    }
    
    func letsPlay() {
        
        let allWords = Int(arc4random_uniform(UInt32(store.arrayOfWords.count)))
        
        secretWord = store.arrayOfWords[allWords - 1].uppercased()
        
        print(secretWord)
        
        for _ in self.secretWord.characters {
            
            self.hiddenWord.append("_")
            
        }
        
            self.secretWordLabel.text = self.hiddenWord
            self.isKeyboardEnabled(status: true)
        
    }
    
    
    func newGame() {
        
        lives = 6
        
        livesLabel?.text = "\(lives)"
        secretWord = ""
        hiddenWord = ""
        wordCharacter = 0
        points = 10
        updateScore()
        
        for button in keyboardButtons {
            
            button.setTitleColor(.white, for: .normal)
            
        }
        
        letsPlay()

        
        
    }
    
    func updateScore() {
        
        if points >= 0 {
            print("positive")
            scoreLabel.text = "+\(points)"
            
            
        } else {
            print("negative")
            scoreLabel.text = "\(points)"
            
        }

    }
    
    
    
}


