//
//  GameViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/15/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var livesLabel: UILabel!
    @IBOutlet weak var secretWordLabel: UILabel!
    
    
    
    @IBOutlet var keyboardButtons: [UIButton]!
    
    let store = HangmanData.sharedInstance
    
    var userName = "Enrique"
    var lives = 6
    var secretWord = ""
    var wordCharacter = 0
    var hiddenWord = ""
    
    
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
    
   
    
    @IBAction func letterPressed(_ sender: UIButton) {
        
        
        var buttonTitle = sender.titleLabel?.text
        
        if secretWord.range(of: buttonTitle!) != nil {
            
            correct(button: sender)
            
        }
        else {
            
            miss(button: sender)
        }
        
        
        }
    
    
    func correct(button: UIButton) {
        
        print("YES I EXIST IN THIS WORD")
        button.setTitleColor(.green, for: .normal)
        button.isEnabled = false
        
        var buttonChar = button.titleLabel?.text?.characters.first!
        
        for (index, char) in secretWord.characters.enumerated() {
            
            if buttonChar == char {
                
                print("WE JUST FOUND A FRIEND OVER HERE! index = \(index), and char = \(char)")
                
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
    
    func isKeyboardEnabled(status: Bool) {
        
        for button in keyboardButtons {
            
            button.isEnabled = status
            
        }

        
    }
    
    
}
