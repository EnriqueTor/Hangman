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
    
    @IBOutlet weak var background: UIImageView!
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
        background.image = store.chalkboard
        print("1")
        setupView()
        print("2")
        retrieveUsers()
        print("3")
        checkIfUserCanPlay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    print("4")
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("5")
        retrieveUsers()
        print("6")
        checkIfUserCanPlay()
        
    }
    
    // MARK: - Methods
    
    func setupView() {
        
        let gameData = self.store.groupGame
        self.titleLabel.text = gameData.title
        self.roundsGame.text = gameData.rounds + " ROUNDS"
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
        
        if user == store.groupGame.player1Id {
            
            cell.playerNameLabel?.text = store.groupGame.player1Name
            cell.retrieveUserPic(url: store.groupGame.player1Pic, image: cell.playerPic!)
            cell.pointsLabel?.text = store.groupGame.player1Points
            cell.gamesPlayed?.text = store.groupGame.player1Rounds + "/" + self.store.groupGame.rounds
        }
        
        if user == store.groupGame.player2Id {
            
            cell.playerNameLabel?.text = store.groupGame.player2Name
            cell.retrieveUserPic(url: store.groupGame.player2Pic, image: cell.playerPic!)
            cell.pointsLabel?.text = store.groupGame.player2Points
            cell.gamesPlayed?.text = store.groupGame.player2Rounds + "/" + self.store.groupGame.rounds
            
        }
        
        if user == store.groupGame.player3Id {
            
            cell.playerNameLabel?.text = store.groupGame.player3Name
            cell.retrieveUserPic(url: store.groupGame.player3Pic, image: cell.playerPic!)
            cell.pointsLabel?.text = store.groupGame.player3Points
            cell.gamesPlayed?.text = store.groupGame.player3Rounds + "/" + self.store.groupGame.rounds
        }
        
        if user == store.groupGame.player4Id {
            
            cell.playerNameLabel?.text = store.groupGame.player4Name
            cell.retrieveUserPic(url: store.groupGame.player4Pic, image: cell.playerPic!)
            cell.pointsLabel?.text = store.groupGame.player4Points
            cell.gamesPlayed?.text = store.groupGame.player4Rounds + "/" + self.store.groupGame.rounds
        }
        
        return cell
    }
    
    
    
    func retrieveUsers() {
        
        var userAndPoints = [store.groupGame.player1Id: store.groupGame.player1Points]
        
        if store.groupGame.player2Id != "" {
            userAndPoints[store.groupGame.player2Id] = store.groupGame.player2Points
        }
        
        if store.groupGame.player3Id != "" {
            userAndPoints[store.groupGame.player3Id] = store.groupGame.player3Points
        }
        
        if store.groupGame.player4Id != "" {
            userAndPoints[store.groupGame.player4Id] = store.groupGame.player4Points
        }
        
        var key = Array(userAndPoints.keys)
        
        key.sort { (o1, o2) -> Bool in
            
            return Int32(userAndPoints[o1]!)! > Int32(userAndPoints[o2]!)!
        }
        self.players = key
        
        tableView.reloadData()
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
        
        gameEnded(playerId: store.groupGame.player1Id, playerRounds: store.groupGame.player1Rounds)
        gameEnded(playerId: store.groupGame.player2Id, playerRounds: store.groupGame.player2Rounds)
        gameEnded(playerId: store.groupGame.player3Id, playerRounds: store.groupGame.player3Rounds)
        gameEnded(playerId: store.groupGame.player4Id, playerRounds: store.groupGame.player4Rounds)
        
    }

    func gameEnded(playerId: String, playerRounds: String) {
        
        if store.user.id == playerId && playerRounds == store.groupGame.rounds {
            
            playGame.isEnabled = false
            playGame.setTitle("FINISHED", for: .normal)
            
            database.child("multiplayerStatus").child(playerId).child("active").child(store.groupGame.id).removeValue()
            database.child("multiplayerStatus").child(playerId).child("finished").child(store.groupGame.id).setValue(getDate(date: Date()))
        }
    }
    
    @IBAction func chatPushed(_ sender: UIButton) {
    }
    
    func getDate(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date).uppercased()
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

