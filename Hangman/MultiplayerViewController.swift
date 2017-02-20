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
    var gameSelected = ""
    
//    var picsStrings = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.image = store.chalkboard
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        
        database.child("multiplayer").child(gameID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.exists() == false {
                
            } else {
                
                guard let data = snapshot.value as? [String:Any] else { return }
                
                DispatchQueue.main.async {
                    cell.gameLabel.text = data["title"] as! String?
                    cell.retrieveUserInfo(url: data["player1Pic"] as! String, image: cell.pic1)
                    cell.retrieveUserInfo(url: data["player2Pic"] as! String, image: cell.pic2)
                    cell.retrieveUserInfo(url: data["player3Pic"] as! String, image: cell.pic3)
                    cell.retrieveUserInfo(url: data["player4Pic"] as! String, image: cell.pic4)
                }
            }
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        gameSelected = activeGames[indexPath.row]
        
        self.performSegue(withIdentifier: "gameInfoSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gameInfoSegue" {

        
//            guard let dest = segue.destination as? CreateGameViewController else { return }
//
//            dest.userLabel.text = store.user.username
//            dest.player2Label.text = store.user2.username
//            dest.player3Label.text = store.user3.username
//            dest.player4Label.text = store.user4.username
//            
//            database.child("multiplayer").child(gameSelected).observeSingleEvent(of: .value, with: { (snapshot) in
//                
//                if snapshot.exists() == false {
//                    
//                } else {
//                    
//                    guard let data = snapshot.value as? [String:Any] else { return }
//                    
//                    DispatchQueue.main.async {
////                        dest.g gameLabel.text = data["title"] as! String?
////                        dest.retrieveUserInfo(url: data["player1Pic"] as! String, image: dest.userPic)
////                        dest.retrieveUserInfo(url: data["player2Pic"] as! String, image: dest.player2Pic)
////                        dest.retrieveUserInfo(url: data["player3Pic"] as! String, image: dest.player3Pic)
////                        dest.retrieveUserInfo(url: data["player4Pic"] as! String, image: dest.player4Pic)
//                    }
//                }
//            })

            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}


class MultiplayerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var pic1: UIImageView!
    @IBOutlet weak var pic2: UIImageView!
    @IBOutlet weak var pic3: UIImageView!
    @IBOutlet weak var pic4: UIImageView!
    
    func retrieveUserInfo(url: String, image: UIImageView) {
        
        let profileImgUrl = URL(string: url)
        
        print(profileImgUrl)
        
        image.contentMode = .scaleAspectFill
        image.setRounded()
        image.clipsToBounds = true
        image.sd_setImage(with: profileImgUrl)
        
        
        print("A")
    }
    
    
}


