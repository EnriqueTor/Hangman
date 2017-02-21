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
        
        refreshUsers()
    }
    
    
    func refreshUsers() {
        
        if store.inviteSelected == 2 {
            retrieveUserInfo(url: (store.user2.profilePic), image: player2Pic, label: player2Label, name: (store.user2.username))
            
            if store.user2Change == false {
                
                store.multiplayerAmountOfPlayers = store.multiplayerAmountOfPlayers + 1
                store.user2Change = true
            }
        }
        
        if store.inviteSelected == 3 {
            retrieveUserInfo(url: (store.user3.profilePic), image: player3Pic, label: player3Label, name: (store.user3.username))
            
            if store.user3Change == false {
                store.multiplayerAmountOfPlayers = store.multiplayerAmountOfPlayers + 1
                store.user3Change = true
            }
        }
        
        if store.inviteSelected == 4 {
            retrieveUserInfo(url: (store.user4.profilePic), image: player4Pic, label: player4Label, name: (store.user4.username))
            
            if store.user4Change == false {
                store.multiplayerAmountOfPlayers = store.multiplayerAmountOfPlayers + 1
                store.user4Change = true
            }
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
        
        if gameNameTextField.text != "" && store.multiplayerAmountOfPlayers >= 2 && store.multiplayerAmountOfWords != "0" {
            
            let root = database.child("multiplayer").childByAutoId()
            let groupID = root.key
            
            let newGroupGame = GroupGame(id: groupID, player1: store.user, player1Pic: store.user.profilePic, player2: store.user2, player2Pic: store.user2.profilePic, player3: store.user3, player3Pic: store.user3.profilePic, player4: store.user4, player4Pic: store.user4.profilePic, date: getDate(date: Date()), status: "active", title: gameNameTextField.text!.uppercased(), words: store.multiplayerAmountOfWords)
            
            database.child("multiplayer").child(groupID).setValue(newGroupGame.serialize())
            
            if newGroupGame.player1.id != "" {
                database.child("multiplayerStatus").child(newGroupGame.player1.id).child("active").child(groupID).setValue(getDate(date: Date()))
                database.child("multiplayerPoints").child(groupID).child(newGroupGame.player1.id).setValue("0")
                database.child("multiplayerRounds").child(groupID).child(newGroupGame.player1.id).setValue("0")
            }
            
            if newGroupGame.player2.id != "" {
                database.child("multiplayerStatus").child(newGroupGame.player2.id).child("active").child(groupID).setValue(getDate(date: Date()))
                database.child("multiplayerPoints").child(groupID).child(newGroupGame.player2.id).setValue("0")
                database.child("multiplayerRounds").child(groupID).child(newGroupGame.player2.id).setValue("0")

            }
            
            if newGroupGame.player3.id != "" {
                database.child("multiplayerStatus").child(newGroupGame.player3.id).child("active").child(groupID).setValue(getDate(date: Date()))
                database.child("multiplayerPoints").child(groupID).child(newGroupGame.player3.id).setValue("0")
                database.child("multiplayerRounds").child(groupID).child(newGroupGame.player3.id).setValue("0")

            }
            
            if newGroupGame.player4.id != "" {
                database.child("multiplayerStatus").child(newGroupGame.player4.id).child("active").child(groupID).setValue(getDate(date: Date()))
                database.child("multiplayerPoints").child(groupID).child(newGroupGame.player4.id).setValue("0")
                database.child("multiplayerRounds").child(groupID).child(newGroupGame.player4.id).setValue("0")

            }
            
        
            store.gameSelected = groupID
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
        performSegue(withIdentifier: "searchSegue", sender: self)
    }
    
    @IBAction func addPlayer3(_ sender: UIButton) {
        store.inviteSelected = 3
        performSegue(withIdentifier: "searchSegue", sender: self)
    }
    
    @IBAction func addPlayer4(_ sender: UIButton) {
        store.inviteSelected = 4
        performSegue(withIdentifier: "searchSegue", sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        gameNameTextField.resignFirstResponder()
        return true
    }
    
}
