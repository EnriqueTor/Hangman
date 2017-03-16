//
//  ResultViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/17/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK: - Outlets 
    
    @IBOutlet weak var backgroundMessage: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var secretWordLabel: UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var defineButton: UIButton!
    
    
    // MARK: - Variables
    
    var gameResult = ""
    var secretWord = ""
    var points = 0
    let store = HangmanData.sharedInstance
    
    // MARK: - Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundMessage.image = store.smallChalkboard
        background.addBlurEffect()
        defineButton.isHidden = true
        showResult()
//        wordInDictionary()
        
    }
    
    // MARK: - Methods
    
    /* This methos brings the secreat word, the result (won or lost) and the points for the user. Also it assigns color accordingly if the user won or not. */
    func showResult() {
        
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
    }
    
//    func wordInDictionary() {
//        
//        if UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: secretWord) == true {
//            
//            defineButton.isHidden = false
//            
//        } else {
//            
//            defineButton.isHidden = true
//        }
//    }
    
    
    /* This methos grabs the secret word and looks for the definition into the Apple's built-in dictionary. */
    
    func defineWord() {
        
        if UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: secretWord) == true {
            
            let ref: UIReferenceLibraryViewController = UIReferenceLibraryViewController(term: secretWord)
        
            
            
            
            present(ref, animated: true, completion: nil)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func closePushed(_ sender: UIButton) {
        
            self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func definePushed(_ sender: UIButton) {
        
        defineWord()
    }
}

extension UIReferenceLibraryViewController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let customFont = UIFont(name: "BiteChalkSlim-regular", size: 20)
        
        self.navigationController?.navigationBar.tintColor = UIColor.lightGray
        
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: customFont!, NSForegroundColorAttributeName: UIColor.lightGray], for: UIControlState.normal)
        
        
        
//        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: customFont!, NSForegroundColorAttributeName: UIColor.lightGray], for: UIControlState.normal)
//        self.navigationItem.rightBarButtonItem?.isEnabled = true
        
    }
}

