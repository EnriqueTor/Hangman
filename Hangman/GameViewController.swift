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
        
        
        nameLabel.text = userName
        livesLabel.text = "\(lives)"
        
        store.getWordFromAPI { (currentData) in
            
            print("WE ARE IN WELCOME VC")
            print(currentData)
            print("YEAH")
            
            self.secretWord = currentData
            
            for _ in self.secretWord.characters {
                
                self.hiddenWord.append("_ ")
                
            }
            
            
            
            
            DispatchQueue.main.async {
                
                self.secretWordLabel.text = self.hiddenWord
            }
        }
        
        
    }
    
    
    @IBAction func letterPressed(_ sender: UIButton) {
        
        print(sender.titleLabel?.text)
        
    }
    
    
    
    
}
