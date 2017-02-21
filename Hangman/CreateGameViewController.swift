//
//  CreateGameViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/19/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class CreateGameViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var player2Label: UILabel!
    @IBOutlet weak var player3Label: UILabel!
    @IBOutlet weak var player4Label: UILabel!
    
    @IBOutlet weak var player2Pic: UIImageView!
    @IBOutlet weak var player3Pic: UIImageView!
    @IBOutlet weak var player4Pic: UIImageView!
    
    @IBOutlet weak var circle5: UIImageView!
    @IBOutlet weak var circle10: UIImageView!
    @IBOutlet weak var circle15: UIImageView!
    
    @IBOutlet weak var gameNameTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    
    // MARK: - Variables
    
    let store = HangmanData.sharedInstance
    let database = FIRDatabase.database().reference()
    
    
    var user1: String = ""
    var totalWords: Int = 0
    
    // MARK: - Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.user2 = User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        store.user3 = User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        store.user4 = User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        
        gameNameTextField.delegate = self
        gameNameTextField.text = ""
        
        store.multiplayerAmountOfPlayers = 1
        store.multiplayerAmountOfWords = "0"
        
        setup()
        
        retrieveUserInfo(url: store.user.profilePic, image: userPic, label: userLabel, name: store.user.username)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Methods
    
    func refreshUsers() {
        
        if store.inviteSelected == 2 {
            retrieveUserInfo(url: (store.user2.profilePic), image: player2Pic, label: player2Label, name: (store.user2.username))
        }
        
        if store.inviteSelected == 3 {
            retrieveUserInfo(url: (store.user3.profilePic), image: player3Pic, label: player3Label, name: (store.user3.username))
        }
        
        if store.inviteSelected == 4 {
            retrieveUserInfo(url: (store.user4.profilePic), image: player4Pic, label: player4Label, name: (store.user4.username))
        }
    }
    
    // MARK: - Methods
    
    func retrieveUserInfo(url: String, image: UIImageView, label: UILabel, name: String) {
        
        let profileImgUrl = URL(string: url)
        
        image.contentMode = .scaleAspectFill
        image.setRounded()
        image.clipsToBounds = true
        
        DispatchQueue.main.async {
            
            image.sd_setImage(with: profileImgUrl)
            label.text = name
        }
    }
    
    func setup() {
        
        hideCircles(number5: true, number10: true, number15: true)
    }
    
    
    @IBAction func number5Pushed(_ sender: UIButton) {
        hideCircles(number5: false, number10: true, number15: true)
        store.multiplayerAmountOfWords = "5"
    }
    
    @IBAction func number10Pushed(_ sender: UIButton) {
        hideCircles(number5: true, number10: false, number15: true)
        store.multiplayerAmountOfWords = "10"
    }
    
    @IBAction func number15Pushed(_ sender: UIButton) {
        hideCircles(number5: true, number10: true, number15: false)
        store.multiplayerAmountOfWords = "15"
    }
    
    func hideCircles(number5: Bool, number10: Bool, number15: Bool) {
        circle5.isHidden = number5
        circle10.isHidden = number10
        circle15.isHidden = number15
    }
    
    @IBAction func createGamePushed(_ sender: UIButton) {
        
        print(gameNameTextField.text)
        print(store.multiplayerAmountOfPlayers)
        print(store.multiplayerAmountOfWords)
        
        
        if gameNameTextField.text == "" || store.user2.username == "" && store.user3.username == "" || store.user4.username == "" || store.multiplayerAmountOfWords == "0" {
            
            let root = database.child("multiplayer").childByAutoId()
            let groupID = root.key
            
            let newGroupGame = GroupGame(id: groupID, date: getDate(date: Date()), status: "active", title: gameNameTextField.text!.uppercased(), rounds: store.multiplayerAmountOfWords, player1Id: store.user.id, player1Name: store.user.username, player1Pic: store.user.profilePic, player1Rounds: "0", player1Points: "0", player2Id: store.user2.id, player2Name: store.user2.username, player2Pic: store.user2.profilePic, player2Rounds: "0", player2Points: "0", player3Id: store.user3.id, player3Name: store.user3.username, player3Pic: store.user3.profilePic, player3Rounds: "0", player3Points: "0", player4Id: store.user4.id, player4Name: store.user4.username, player4Pic: store.user4.profilePic, player4Rounds: "0", player4Points: "0")
            
            database.child("multiplayer").child(groupID).setValue(newGroupGame.serialize())
            
            if newGroupGame.player1Id != "" {
                database.child("multiplayerStatus").child(newGroupGame.player1Id).child("active").child(groupID).setValue(getDate(date: Date()))
                database.child("multiplayerPoints").child(groupID).child(newGroupGame.player1Id).setValue("0")
            }
            
            if newGroupGame.player2Id != "" {
                database.child("multiplayerStatus").child(newGroupGame.player2Id).child("active").child(groupID).setValue(getDate(date: Date()))
                database.child("multiplayerPoints").child(groupID).child(newGroupGame.player2Id).setValue("0")
            }
            
            if newGroupGame.player3Id != "" {
                database.child("multiplayerStatus").child(newGroupGame.player3Id).child("active").child(groupID).setValue(getDate(date: Date()))
                database.child("multiplayerPoints").child(groupID).child(newGroupGame.player3Id).setValue("0")
            }
            
            if newGroupGame.player4Id != "" {
                database.child("multiplayerStatus").child(newGroupGame.player4Id).child("active").child(groupID).setValue(getDate(date: Date()))
                database.child("multiplayerPoints").child(groupID).child(newGroupGame.player4Id).setValue("0")
            }
            
            store.gameSelected = groupID
            store.user2.username = ""
            store.user3.username = ""
            store.user4.username = ""
            store.multiplayerAmountOfWords = "0"
            
            navigationController?.popViewController(animated: true)
        }
    }
    
    func getDate(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date).uppercased()
    }
    
    @IBAction func addPlayer2(_ sender: UIButton) {
        store.inviteSelected = 2
        //        refreshUsers()
        performSegue(withIdentifier: "searchSegue", sender: self)
    }
    
    @IBAction func addPlayer3(_ sender: UIButton) {
        store.inviteSelected = 3
        //        refreshUsers()
        performSegue(withIdentifier: "searchSegue", sender: self)
    }
    
    @IBAction func addPlayer4(_ sender: UIButton) {
        store.inviteSelected = 4
        //        refreshUsers()
        performSegue(withIdentifier: "searchSegue", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        gameNameTextField.resignFirstResponder()
        return true
    }
    
}
