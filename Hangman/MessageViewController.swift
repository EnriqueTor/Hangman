//
//  MessageViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/18/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var backgroundMessage: UIImageView!
    @IBOutlet weak var background: UIImageView!
    
    let store = HangmanData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundMessage.image = store.smallChalkboard
        background.addBlurEffect()
//        titleLabel.textColor = Constants.Colors.chalkBlue
    }

   
    
    
    @IBAction func closePushed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func starPushed(_ sender: UIButton) {
        
        
        
        
    }
    
    
}
