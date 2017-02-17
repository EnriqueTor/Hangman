//
//  LeaderboardSingleViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/17/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit

class LeaderboardSingleViewController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    
    @IBOutlet weak var singleButton: UITabBarItem!
    
    let store = HangmanData.sharedInstance
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        background.image = store.chalkboard

        tabBarController?.tabBar.transparentNavigationBar()
              
    }

    
}
