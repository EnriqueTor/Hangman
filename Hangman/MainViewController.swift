//
//  MainViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/15/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UINavigationControllerDelegate {

    
    
    @IBOutlet weak var background: UIImageView!

    
    
    let store = HangmanData.sharedInstance
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        background.image = store.chalkboard
        self.navigationController?.navigationBar.transparentNavigationBar()

        
        
        
        
        
        self.title = "HANGMAN"
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            
        self.background.image = self.store.chalkboard
        
        }
    }
    
    
    @IBAction func settingsPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "settingsSegue", sender: self)
        
    }

    @IBAction func leaderboardPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "leaderboardSegue", sender: self)
        
    }
  
    
    
}
