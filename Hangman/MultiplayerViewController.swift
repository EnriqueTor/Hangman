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
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var activityInfo: UIActivityIndicatorView!
    
    // MARK: - Variables
    
    let store = HangmanData.sharedInstance
    let database = FIRDatabase.database().reference()
    var games = [String]()
    var gameSelected = ""
    var gameRounds = ""
    
    // MARK: - Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.image = store.chalkboard
        retrieveActiveGames()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        retrieveActiveGames()
    }
    
    // MARK: - Methods
    
    /* This method retrieves from firbase the active games of the user */
    func retrieveActiveGames() {
        
        database.child("multiplayerStatus").child(store.user.id).child("active").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.exists() == false {
                
                self.games = []
                self.tableView.reloadData()

            } else {
                
                guard let data = snapshot.value as? [String:Any] else { return }
                
                self.games = Array(data.keys)
                self.tableView.reloadData()
            }
        })
    }
    
    /* This method retrieves from firbase the finished games of the user */
    func retrieveFinishedGames() {
        
        database.child("multiplayerStatus").child(store.user.id).child("finished").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.exists() == false {
                
                self.games = []
                self.tableView.reloadData()
                
            } else {
                
                guard let data = snapshot.value as? [String:Any] else { return }
                
                self.games = Array(data.keys)
                self.tableView.reloadData()
            }
        })
    }
    
    // MARK: - Methods TableView
    
    /* This method set the amount of rows the TableView will have */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return games.count
    }
    
    /* This method takes the userID and retrieved their data to display in the tableView. */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "multiplayerCell", for: indexPath) as! MultiplayerTableViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let gameID = games[indexPath.row]
        
        database.child("multiplayer").child(gameID).observe(.value, with: { (snapshot) in
            
            if snapshot.exists() == false {
                
            } else {
                
                DispatchQueue.main.async {
                
                let newGroupGame = GroupGame(snapshot: snapshot)
                    
                    cell.gameLabel.text = newGroupGame.title
                    cell.retrieveUserInfo(url: newGroupGame.player1Pic, image: cell.pic1)
                    cell.retrieveUserInfo(url: newGroupGame.player2Pic, image: cell.pic2)
                    cell.retrieveUserInfo(url: newGroupGame.player3Pic, image: cell.pic3)
                    cell.retrieveUserInfo(url: newGroupGame.player4Pic, image: cell.pic4)
                }
            }
        })
        
        return cell
    }
    
    /* This method retrieves data from Firebase depending on what player we picked. */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        gameSelected = games[indexPath.row]
        store.gameSelected = gameSelected
        
        database.child("multiplayer").child(gameSelected).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let gameData = GroupGame(snapshot: snapshot)
            
            self.store.groupGame = gameData
            
            self.activityInfo.startAnimating()

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.activityInfo.stopAnimating()
                self.performSegue(withIdentifier: "gameInfo2Segue", sender: self)
            })
        })
    }
    
    /* This method shows 100 users, if people wants to see more they can use the search functions */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return 100
    }
    
    // MARK: - Actions
    
    @IBAction func createGamePushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "createGameSegue", sender: self)
    }
    
    @IBAction func activeGamesPushed(_ sender: UIButton) {
        
        retrieveActiveGames()
    }
    
    @IBAction func archivedGamesPushed(_ sender: UIButton) {
       
        retrieveFinishedGames()
    }
}

class MultiplayerTableViewCell: UITableViewCell {
    
    // MARK: - Outlets 
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var pic1: UIImageView!
    @IBOutlet weak var pic2: UIImageView!
    @IBOutlet weak var pic3: UIImageView!
    @IBOutlet weak var pic4: UIImageView!
    
    // MARK: - Methods
    
    func retrieveUserInfo(url: String, image: UIImageView) {
        
        let profileImgUrl = URL(string: url)
        
        image.contentMode = .scaleAspectFill
        image.setRounded()
        image.clipsToBounds = true
        image.sd_setImage(with: profileImgUrl)
        
    }
}


