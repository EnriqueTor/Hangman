//
//  MultiplayerViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/19/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit
import Firebase

class MultiplayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var background: UIImageView!
    
   
    
    let store = HangmanData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        background.image = store.chalkboard
        
        
        
        tableView.reloadData()
    }

    
    @IBAction func createGamePushed(_ sender: UIButton) {
        
        
    }
    
    
    @IBAction func activeGamesPushed(_ sender: UIButton) {
        
        
    }
    
    @IBAction func archivedGamesPushed(_ sender: UIButton) {
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "multiplayerCell", for: indexPath) as! MultiplayerTableViewCell
        
        
        cell.backgroundColor = UIColor.clear
        
        
         cell.gameLabel.text = "THE BEST TEAM"
        
        cell.user1Pic.setRounded()
        cell.user2Pic.setRounded()
        cell.user3Pic.setRounded()
        cell.user4Pic.setRounded()

        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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


