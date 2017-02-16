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
        
        for button in keyboardButtons {
            
            button.isEnabled = false
            
        }
        
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
                
                for button in self.keyboardButtons {
                    
                    button.isEnabled = true
                    
                }
            }
        }
        
        
    }
    
   
    
    @IBAction func letterPressed(_ sender: UIButton) {
        
        
        var buttonTitle = sender.titleLabel?.text
        
        print(secretWord)
        print(buttonTitle!)
        
        if secretWord.range(of: buttonTitle!) != nil {
            
            print("YES I EXIST IN THIS WORD")
            sender.setTitleColor(.green, for: .normal)
            
        }
        else {
            sender.setTitleColor(.red, for: .normal)
            lives = lives - 1
            livesLabel.text = "\(lives)"
            print("GOOD LUCK NEXT TIME!")
            print(lives)
            
        }
        
        
        }
    
    
    
    
}
