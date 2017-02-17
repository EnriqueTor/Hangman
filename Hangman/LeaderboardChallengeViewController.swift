//
//  LeaderboardChallengeViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/17/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit

class LeaderboardChallengeViewController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    
    
    
    let store = HangmanData.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        background.image = store.chalkboard
        
        tabBarController?.tabBar.isTranslucent = true
        
        
        
    }

}
