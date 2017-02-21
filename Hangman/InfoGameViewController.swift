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
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var roundsGame: UILabel!
    @IBOutlet weak var playGame: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    var gameTitle = ""
    var players: [String] = []
    let database = FIRDatabase.database().reference()
    let store = HangmanData.sharedInstance
    var points: [String:String] = [:]
    var gameRounds = ""
    var userAmountOfRounds: [String:String] = [:]
    
    // MARK: - Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("===============================================")
        print("===============================================")
        print("===============================================")
        
        print(store.groupGame)
        print(store.gameSelected)
        
        print("===============================================")
        print("===============================================")
        print("===============================================")
        
        retrieveUsers()
        
                retrieveGameData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        


    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        retrieveUsers()
        checkIfUserCanPlay()
    }
    
    // MARK: - Methods
    
    func retrieveGameData() {
        
        DispatchQueue.main.async {
            
            self.database.child("multiplayer").child(self.store.gameSelected).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let gameData = GroupGame(snapshot: snapshot)
                self.store.groupGame = gameData
                
                self.store.groupGame = gameData
                self.titleLabel.text = gameData.title
                self.roundsGame.text = gameData.rounds + " ROUNDS"
            })
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as! InfoTableViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        cell.positionLabel?.text = "\(Int(indexPath.row) + 1)."

        let user = players[indexPath.row]
        
        print("THIS IS THE USER!!!!")
        print(user)
        
        if user == store.groupGame.player1Id {
            
            cell.playerNameLabel?.text = store.groupGame.player1Name
            cell.retrieveUserPic(url: store.groupGame.player1Pic, image: cell.playerPic!)
            cell.pointsLabel?.text = store.groupGame.player1Points
            cell.gamesPlayed?.text = store.groupGame.player1Rounds + "/" + self.store.gameRounds
        }
        
        if user == store.groupGame.player2Id {
            
            cell.playerNameLabel?.text = store.groupGame.player2Name
            cell.retrieveUserPic(url: store.groupGame.player2Pic, image: cell.playerPic!)
            cell.pointsLabel?.text = store.groupGame.player2Points
            cell.gamesPlayed?.text = store.groupGame.player2Rounds + "/" + self.store.gameRounds

        }
        
        if user == store.groupGame.player3Id {
          
            cell.playerNameLabel?.text = store.groupGame.player3Name
            cell.retrieveUserPic(url: store.groupGame.player3Pic, image: cell.playerPic!)
            cell.pointsLabel?.text = store.groupGame.player3Points
            cell.gamesPlayed?.text = store.groupGame.player3Rounds + "/" + self.store.gameRounds
        }
        
        if user == store.groupGame.player4Id {
            
            cell.playerNameLabel?.text = store.groupGame.player4Name
            cell.retrieveUserPic(url: store.groupGame.player4Pic, image: cell.playerPic!)
            cell.pointsLabel?.text = store.groupGame.player4Points
            cell.gamesPlayed?.text = store.groupGame.player4Rounds + "/" + self.store.gameRounds
        }
        
        return cell
    }
    
    
    
    func retrieveUsers() {
        
        database.child("multiplayerPoints").child(store.gameSelected).observe(.value, with: { (snapshot) in
            
            if snapshot.exists() == false {
                
            } else {
                
                guard let data = snapshot.value as? [String : String] else { return }
                
                self.points = data
                var key = Array(data.keys)
                
                key.sort { (o1, o2) -> Bool in
                    
                    return Int32(data[o1]!)! > Int32(data[o2]!)!
                }
                self.players = key
                
                self.tableView.reloadData()
            }
            
        })
    }
    
    
    @IBAction func playPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "playMultiplayerSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let dest = segue.destination as? GameViewController else { return }
        
        dest.typeOfGame = "MULTIPLAYER"
        dest.groupID = store.gameSelected
    }
    
    func checkIfUserCanPlay() {
        
        
        
        if userAmountOfRounds[store.user.id] == gameRounds {
            
            playGame.isEnabled = false
            
            playGame.titleLabel?.text = "DONE"
            
            
            
        }
        
        
        
    }
    
    
    @IBAction func chatPushed(_ sender: UIButton) {
    }
    
}


class InfoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var playerNameLabel: UILabel?
    @IBOutlet weak var playerPic: UIImageView?
    
    @IBOutlet weak var gamesPlayed: UILabel?
    @IBOutlet weak var pointsLabel: UILabel?
    @IBOutlet weak var positionLabel: UILabel?
    
    func retrieveUserPic(url: String, image: UIImageView) {
        
        let profileImgUrl = URL(string: url)
        
        image.contentMode = .scaleAspectFill
        image.setRounded()
        image.clipsToBounds = true
        image.sd_setImage(with: profileImgUrl)
        
    }
    
}

