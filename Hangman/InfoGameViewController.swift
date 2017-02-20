//
//  InfoGameViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/20/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit
import Firebase

class InfoGameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var gameTitle = ""
    
    var players: [String] = []
    let database = FIRDatabase.database().reference()
    let store = HangmanData.sharedInstance
    var points: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if gameTitle != "" {
            
        titleLabel.text = gameTitle
        }
    
    }
    
   
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoTableViewCell
        
        let user = players[indexPath.row]
        
        database.child("users").child(user).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let data = snapshot.value as? [String:Any] else { return }
            
            cell.playerNameLabel.text = data["username"] as? String
            
            cell.retrieveUserPic(url: data["profilePic"] as! String, image: cell.playerPic)
            
            cell.backgroundColor = UIColor.clear
            
            cell.positionLabel.text = "\(Int(indexPath.row) + 1)."
            
            cell.selectionStyle = .none
            
            cell.pointsLabel.text = self.points[user]
            
        })
        
        return cell
    }
    
    
    
    func retrieveUserPoints() {
        
        database.child("multiplayerPoints").child(store.gameSelected).observe(.value, with: { (snapshot) in
            
            if snapshot.exists() == false {
                
            } else {
                
                guard let data = snapshot.value as? [String : String] else { return }
                
                
                points = data
                
                var key = Array(data.keys)
                
                key.sort { (o1, o2) -> Bool in
                    
                    return Int32(data[o1]!)! > Int32(data[o2]!)!
                }
                
                self.players = key
                
//                if let position = self.players.index(where: {$0 == self.store.user.id}) {
//                    
//                    self.userSimplePosition = "\(Int(position) + 1)" ?? "?"
//                    self.retrieveUserInfo(url: self.store.user.profilePic, image: self.userPic, position: self.userSimplePosition, name: self.store.user.username, points: self.store.user.scoreSingle)
//                    self.tableView.reloadData()
//                    
//                } else {
//                    
//                    self.retrieveUserInfo(url: self.store.user.profilePic, image: self.userPic, position: "???", name: self.store.user.username, points: "???")
//                    self.tableView.reloadData()
//                }
            }
            self.tableView.reloadData()

        })
    }

    
    
    
    
    
   
}


class InfoTableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerPic: UIImageView!
    
    @IBOutlet weak var gamesPlayed: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    func retrieveUserPic(url: String, image: UIImageView) {
        
        let profileImgUrl = URL(string: url)
        
        image.contentMode = .scaleAspectFill
        image.setRounded()
        image.clipsToBounds = true
        image.sd_setImage(with: profileImgUrl)
        
    }

}

