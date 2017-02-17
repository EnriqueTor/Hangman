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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var livesLabel: UILabel!
    @IBOutlet weak var secretWordLabel: UILabel!
    @IBOutlet var keyboardButtons: [UIButton]!
    
    // MARK: - Variables
    
    let store = HangmanData.sharedInstance
    var lives = 6
    var secretWord = ""
    var wordCharacter = 0
    var hiddenWord = ""
    
    // MARK: - Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isKeyboardEnabled(status: false)
        newGame()
        
        background.image = store.chalkboard
        
        print("HOLA!")
        
        
    }
    
    // MARK: - Actions
    
    
    @IBAction func backPushed(_ sender: UIButton) {
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
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
                win()
            }
            
        }
        
    }
    
    func miss(button: UIButton) {
        
        button.setTitleColor(.red, for: .normal)
        button.isEnabled = false
        
        lives = lives - 1
        livesLabel.text = "\(lives)"
        
        isHangman()
        
    }
    
    func isHangman() {
        
        if lives < 0 {
            
            livesLabel.text = "GAME OVER"
            isKeyboardEnabled(status: false)
            
        }
        
    }
    
    func win() {
        
        if secretWord == hiddenWord {
            
            isKeyboardEnabled(status: false)
            
            livesLabel.text = "YOU WON!"
            
            
//            if UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: secretWord) == true {
//                
//                print("YES WE HAVE A DEFINITION")
//                
//                let ref: UIReferenceLibraryViewController = UIReferenceLibraryViewController(term: secretWord)
//                
//                present(ref, animated: true, completion: nil)
//                
            } else {
                
                "the word doesn't exist"
            }
            
//        }
        
        
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
    
    @IBAction func newPushed(_ sender: UIButton) {
        
        self.viewDidLoad()
        self.viewDidAppear(true)
        newGame()
        
    }
    
    func newGame() {
        
        lives = 6
        nameLabel.text = store.user.username
        livesLabel.text = "\(lives)"
        secretWord = ""
        hiddenWord = ""
        wordCharacter = 0
        
        for button in keyboardButtons {
            
            button.setTitleColor(.white, for: .normal)
            
        }
        
        letsPlay()

        
        
    }
    
}


