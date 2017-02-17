//
//  WelcomeViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/15/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    let store = HangmanData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
                
        
        
        
        
        
    }

    
    @IBAction func loginPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "loginSegue", sender: self)
        
    }
    
    
    @IBAction func registerPushed(_ sender: UIButton) {
        

    }
    
    
}

