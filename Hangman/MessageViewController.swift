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
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.textColor = Constants.Colors.chalkBlue
        // Do any additional setup after loading the view.
    }

   
    
    
    @IBAction func closePushed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func starPushed(_ sender: UIButton) {
        
        
        
        
    }
    
    
}
