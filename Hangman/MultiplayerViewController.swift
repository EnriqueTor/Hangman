//
//  MultiplayerViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/19/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class MultiplayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var background: UIImageView!
    
   
    
    let store = HangmanData.sharedInstance
    let database = FIRDatabase.database().reference()
    var activeGames = [String]()
    var picsStrings = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        background.image = store.chalkboard
        
        
        tableView.reloadData()
    }

    
    @IBAction func createGamePushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "createGameSegue", sender: self)
        
    }
    
    
    @IBAction func activeGamesPushed(_ sender: UIButton) {
        
        
    }
    
    @IBAction func archivedGamesPushed(_ sender: UIButton) {
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "multiplayerCell", for: indexPath) as! MultiplayerTableViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let gameID = activeGames[indexPath.row]
        print(gameID)
        
        database.child("multiplayer").child(gameID).child("data").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.exists() == false {
            
            } else {
                
                guard let data = snapshot.value as? [String:Any] else { return }
                cell.gameLabel.text = data["title"] as? String
            }
            
        })
        
        database.child("multiplayer").child(gameID).child("players").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.exists() == false {
                
            } else {
                
                guard let data = snapshot.value as? [String:Any] else { return }
                
                var picPosition = 0
                
                for (_, value) in data {
                    
                self.database.child("users").child(value as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                
                    guard let data = snapshot.value as? [String:Any] else { return }
                    
                    let profileImgUrl = URL(string: data["profilePic"]! as! String)
                    
                    cell.picturePlayers[picPosition].isHidden = false
                    cell.picturePlayers[picPosition].contentMode = .scaleAspectFill
                    cell.picturePlayers[picPosition].setRounded()
                    cell.picturePlayers[picPosition].clipsToBounds = true
                    
                    
                    DispatchQueue.main.async {
                        
                        cell.picturePlayers[indexPath.row + picPosition].sd_setImage(with: profileImgUrl)
                        picPosition = picPosition + 1

                    }
                    
                    })
                }
            }
        })
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


class MultiplayerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet var picturePlayers: [UIImageView]!
    
    
    
    func retrieveUserInfo(url: String, image: UIImageView, position: Int, name: String, points: String) {
        
        let profileImgUrl = URL(string: url)
        
        image.contentMode = .scaleAspectFill
        image.setRounded()
        image.clipsToBounds = true
        image.sd_setImage(with: profileImgUrl)
        
        gameLabel.text = name
    }
    
    
}


