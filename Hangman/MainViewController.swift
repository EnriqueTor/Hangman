//
//  MainViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/15/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    
    @IBOutlet weak var background: UIImageView!

    
    
    let store = HangmanData.sharedInstance
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        background.image = store.chalkboard

    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            
        self.background.image = self.store.chalkboard
        
        }
    }
    
    @IBAction func playPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "playSegue", sender: self)
        
    }
    
    
    @IBAction func settingsPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "settingsSegue", sender: self)
        
    }
    
    
    
    
    
    
    
}
