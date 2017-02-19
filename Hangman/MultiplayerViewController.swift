//
//  MultiplayerViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/19/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit
import Firebase

class MultiplayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func createGamePushed(_ sender: UIButton) {
        
        
        
    }
    
    
    @IBAction func activeGamesPushed(_ sender: UIButton) {
        
        
        
        
    }
    
    @IBAction func archivedGamesPushed(_ sender: UIButton) {
        
        
        
        
    }
    
}


class MultiplayerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var user1Pic: UIImageView!
    @IBOutlet weak var user2Pic: UIImageView!
    @IBOutlet weak var user3Pic: UIImageView!
    @IBOutlet weak var user4Pic: UIImageView!
    @IBOutlet weak var gameLabel: UILabel!


    
    
    
    func retrieveUserInfo(url: String, image: UIImageView, position: Int, name: String, points: String) {
        
        let profileImgUrl = URL(string: url)
        
        image.contentMode = .scaleAspectFill
        image.setRounded()
        image.clipsToBounds = true
        image.sd_setImage(with: profileImgUrl)
        
        gameLabel.text = name
    }
    
}


