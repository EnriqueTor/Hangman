//
//  ResultViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/17/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var secretWordLabel: UILabel!
    @IBOutlet weak var backround: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    var gameResult = ""
    var secretWord = ""
    var points = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = gameResult
        secretWordLabel.text = secretWord
        
        if points >= 0 {
            print("positive")
                scoreLabel.text = "+\(points)"
                scoreLabel.textColor = Constants.Colors.chalkGreen
            
        } else {
            print("negative")
            scoreLabel.text = "\(points)"
                scoreLabel.textColor = Constants.Colors.chalkRed
        }
        
        backround.addBlurEffect()
        
    }
    
    
    @IBAction func newPushed(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: .openGameVC, object: nil)
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func closePushed(_ sender: UIButton) {
        
        
        NotificationCenter.default.post(name: .openMainVC, object: nil)
        dismiss(animated: true, completion: nil)
        
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
