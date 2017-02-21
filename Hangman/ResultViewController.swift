//
//  ResultViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/17/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    
    @IBOutlet weak var backgroundMessage: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var secretWordLabel: UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!    
    
    var gameResult = ""
    var secretWord = ""
    var points = 0
    let store = HangmanData.sharedInstance
    var typeOfGame = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundMessage.image = store.smallChalkboard
        resultLabel.text = gameResult
        secretWordLabel.text = secretWord
        
        if points >= 0 {
                scoreLabel.text = "+\(points)"
            
        } else {
            scoreLabel.text = "\(points)"
        }
        
        if gameResult == "YOU WON" {
            scoreLabel.textColor = Constants.Colors.chalkGreen

        } else {
            scoreLabel.textColor = Constants.Colors.chalkRed
            
        }
        
        if typeOfGame == "CHALLENGE" {
            
            newButton.isEnabled = false
            newButton.isHidden = true
            
        }
        
        
        background.addBlurEffect()
        
    }
    
    @IBAction func closePushed(_ sender: UIButton) {
        
        if typeOfGame == "SINGLE" || typeOfGame == "CHALLENGE" {
            
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

        }
        
        if typeOfGame == "MULTIPLAYER" {
            
            
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            

        }
        
    }
    
    @IBAction func definePushed(_ sender: UIButton) {
        
        if UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: secretWord) == true {
            
            print("YES WE HAVE A DEFINITION")
            
            let ref: UIReferenceLibraryViewController = UIReferenceLibraryViewController(term: secretWord)
            
            present(ref, animated: true, completion: nil)
            
        }
    }
    
    func saveResultInfo() {
    
        
        
    
    }
        
}
