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
    @IBOutlet weak var roundsGame: UILabel!
    @IBOutlet weak var playGame: UIButton!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var gameTitle = ""
    
    var players: [String] = []
    let database = FIRDatabase.database().reference()
    let store = HangmanData.sharedInstance
    var points: [String:String] = [:]
    var gameRounds = ""
    var userAmountOfRounds: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("===============================================")
        print("===============================================")
        print("===============================================")
        
        print(store.groupGame)
        
        print("===============================================")
        print("===============================================")
        print("===============================================")
        
        if gameTitle != "" {
            
            titleLabel.text = gameTitle
        }
        retrieveUserPoints()
        retrieveRounds()
        
        print(gameRounds)
        
        DispatchQueue.main.async {
            
        self.roundsGame.text = self.store.gameRounds + " ROUNDS"
            
            print(self.store.gameRounds)
            print(self.roundsGame.text)
        }
        
        
//        retrieveGameData()

        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.roundsGame.text = self.store.gameRounds + " ROUNDS"
        checkIfUserCanPlay()
    }
    
    func retrieveRounds() {
       
        DispatchQueue.main.async {
            
        self.database.child("multiplayerRounds").child(self.store.gameSelected).observeSingleEvent(of: .value, with: { (snapshot) in
            print("2b")
            guard let data = snapshot.value as? [String:String] else { return }
            
            print("2c")
            self.userAmountOfRounds = data
            print(self.userAmountOfRounds)
        })
        }
        
    }
    
    func retrieveGameData() {
        
        
        DispatchQueue.main.async {
            
        self.database.child("multiplayer").child(self.store.gameSelected).observeSingleEvent(of: .value, with: { (snapshot) in
                            guard let data = snapshot.value as? [String:Any] else { return }
                            self.titleLabel.text = data["title"] as? String
            
//                            let rounds = data["words"] as? String
//            self.gameRounds = rounds!
                            self.roundsGame.text = self.gameRounds + " ROUNDS"
        })

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
            
            DispatchQueue.main.async {
                
            cell.playerNameLabel?.text = data["username"] as? String
            
            cell.retrieveUserPic(url: data["profilePic"] as! String, image: cell.playerPic!)
            
            
                
            cell.backgroundColor = UIColor.clear
            
            cell.positionLabel?.text = "\(Int(indexPath.row) + 1)."
            
            cell.selectionStyle = .none
            
            cell.pointsLabel?.text = self.points[user]
            

            
            }
        })
        
        database.child("multiplayerRounds").child(store.gameSelected).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let data = snapshot.value as? [String:Any] else { return }
            
            cell.gamesPlayed?.text = (data[user] as! String?)! + "/" + self.store.gameRounds
            
        })
        
        
        return cell
    }
    
    
    
    func retrieveUserPoints() {
        
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
                
                  }
            self.tableView.reloadData()
            
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

