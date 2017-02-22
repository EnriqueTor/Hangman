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
        setupView()
        retrieveUsers()
        checkIfUserCanPlay()
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
    
    func setupView() {
        
        let gameData = self.store.groupGame
        self.titleLabel.text = gameData.title
        self.roundsGame.text = gameData.rounds + " ROUNDS"
    }
    
    /* Method that assign the amount of rows for the tableView. */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return players.count
    }
    
    /* This assign a user to a cell and then retrieves all the data for that user and display it. */
    // TODO: I think this can be done better
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
    
    
    /* This method checks how many players are playing the Group Game and order them by their point score*/
    // TODO: I think this can be done better
    func retrieveUsers() {
        
        /* create the dictionary */
        var userAndPoints = [store.groupGame.player1Id: store.groupGame.player1Points]
        
        /* check player 2 */
        if store.groupGame.player2Id != "" {
            userAndPoints[store.groupGame.player2Id] = store.groupGame.player2Points
        }
        
        /* check player 3 */
        if store.groupGame.player3Id != "" {
            userAndPoints[store.groupGame.player3Id] = store.groupGame.player3Points
        }
        
        /* check player 4 */
        if store.groupGame.player4Id != "" {
            userAndPoints[store.groupGame.player4Id] = store.groupGame.player4Points
        }
        
        /* create an array from the dictionary */
        var key = Array(userAndPoints.keys)
        
        /* order them accordingly to their high score */
        key.sort { (o1, o2) -> Bool in
            
            return Int32(userAndPoints[o1]!)! > Int32(userAndPoints[o2]!)!
        }
        /* asign the new array to the array players */
        self.players = key
        
        tableView.reloadData()
    }

    /* This method saves the groupGameId and also saves the typeGame. Both informations will be useful once we segue */
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

    /* This method checks if the user finished all his rounds. If he did the systems will move the Group Game from the Active child to the Finished one in MultiplayerStatus database. */
    func gameEnded(playerId: String, playerRounds: String) {
        
        if store.user.id == playerId && playerRounds == store.groupGame.rounds {
            
            playGame.isEnabled = false
            playGame.setTitle("FINISHED", for: .normal)
            
            database.child("multiplayerStatus").child(playerId).child("active").child(store.groupGame.id).removeValue()
            database.child("multiplayerStatus").child(playerId).child("finished").child(store.groupGame.id).setValue(getDate(date: Date()))
        }
    }
    
    /* This method retrieves Today's date. */
    func getDate(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date).uppercased()
    }
    
    // MARK: - Actions
    
    @IBAction func playPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "playMultiplayerSegue", sender: self)
    }
    
}


class InfoTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var playerNameLabel: UILabel?
    @IBOutlet weak var playerPic: UIImageView?
    @IBOutlet weak var gamesPlayed: UILabel?
    @IBOutlet weak var pointsLabel: UILabel?
    @IBOutlet weak var positionLabel: UILabel?
    
    // MARK: - Methods
    
    func retrieveUserPic(url: String, image: UIImageView) {
        
        let profileImgUrl = URL(string: url)
        
        image.contentMode = .scaleAspectFill
        image.setRounded()
        image.clipsToBounds = true
        image.sd_setImage(with: profileImgUrl)
        
    }
    
}

