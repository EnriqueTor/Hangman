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
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var livesLabel: UILabel!
    @IBOutlet weak var secretWordLabel: UILabel!
    @IBOutlet var keyboardButtons: [UIButton]!
    
    // MARK: - Variables
    
    let store = HangmanData.sharedInstance
    var userName = "Enrique"
    var lives = 6
    var secretWord = ""
    var wordCharacter = 0
    var hiddenWord = ""
    
    // MARK: - Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isKeyboardEnabled(status: false)
        
        nameLabel.text = userName
        livesLabel.text = "\(lives)"
        
        store.getWordFromAPI { (currentData) in
            
            print("WE ARE IN WELCOME VC")
            print(currentData)
            print("YEAH")
            
            self.secretWord = currentData.uppercased()
            
            for _ in self.secretWord.characters {
                
                self.hiddenWord.append("_")
                
            }
            
            
            
            
            DispatchQueue.main.async {
                
                self.secretWordLabel.text = self.hiddenWord
                
                self.isKeyboardEnabled(status: true)
            }
        }
        
        
    }
    
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
        
        print("YES I EXIST IN THIS WORD")
        button.setTitleColor(.green, for: .normal)
        button.isEnabled = false
        
        var buttonChar = button.titleLabel?.text?.characters.first!
        
        for (index, char) in secretWord.characters.enumerated() {
            
            if buttonChar == char {
                
                print("WE JUST FOUND A FRIEND OVER HERE! index = \(index), and char = \(char)")
                
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
        
        print("GOOD LUCK NEXT TIME!")
        
        isHangman()
        
        
        
        
        
    }
    
    
    
    
    func isHangman() {
        
        if lives < 0 {
            
            print("THE GAME IS OVER")
            livesLabel.text = "GAME OVER"
            isKeyboardEnabled(status: false)
            
            
        }
        
        
    }
    
    func win() {
        
        if secretWord == hiddenWord {
            
            isKeyboardEnabled(status: false)
            
            if UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: secretWord) == true {
                
                print("YES WE HAVE A DEFINITION")
                
                let ref: UIReferenceLibraryViewController = UIReferenceLibraryViewController(term: secretWord)
                
                present(ref, animated: true, completion: nil)
                
            } else {
                
                "the word doesn't exist"
            }
            
            print("YOU WON!!!!")
            
        }
        
        
    }
    
    func isKeyboardEnabled(status: Bool) {
        
        for button in keyboardButtons {
            
            button.isEnabled = status
            
        }
        
        
    }
    
    
}
