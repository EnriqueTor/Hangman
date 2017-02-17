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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = gameResult
        secretWordLabel.text = secretWord
        
        backround.addBlurEffect()
        
    }
    
    
    @IBAction func newPushed(_ sender: UIButton) {
        
        
        
    }
    
    
    @IBAction func closePushed(_ sender: UIButton) {
        
        
        
        
    }
    
    @IBAction func definePushed(_ sender: UIButton) {
        
        if UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: secretWord) == true {
            
            print("YES WE HAVE A DEFINITION")
            
            let ref: UIReferenceLibraryViewController = UIReferenceLibraryViewController(term: secretWord)
            
            present(ref, animated: true, completion: nil)
            
        }
    }
        
}
