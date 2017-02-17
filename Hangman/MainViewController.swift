//
//  MainViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/15/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    
    }

  
    
    
    @IBAction func playPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "playSegue", sender: self)
        
    }
    
    
    @IBAction func settingsPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "settingsSegue", sender: self)
        
    }
    
    
    
    
    
    
    
}
