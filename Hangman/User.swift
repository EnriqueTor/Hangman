//
//  User.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/16/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    var id: String
    var username: String
    var email: String
    var profilePic: String
    var scoreSingle: String
    var singleWon: String
    var singleLost: String
    var scoreChallenge: String
    var scoreMultiplayer: String
    
    init(id: String, username: String, email: String, profilePic: String, scoreSingle: String, singleWon: String, singleLost: String, scoreChallenge: String, scoreMultiplayer: String) {
        
        self.id = id
        self.username = username
        self.email = email
        self.profilePic = profilePic
        self.scoreSingle = scoreSingle
        self.singleWon = singleWon
        self.singleLost = singleLost
        self.scoreChallenge = scoreChallenge
        self.scoreMultiplayer = scoreMultiplayer
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as? [String : Any]
        
        id = snapshotValue?["id"] as? String ?? "No id"
        username = snapshotValue?["username"] as? String ?? "No username"
        email = snapshotValue?["email"] as? String ?? "No email"
        profilePic = snapshotValue?["profilePic"] as? String ?? "No profile pic"
        scoreSingle = snapshotValue?["scoreSingle"] as? String ?? "No scoreSingle"
        singleWon = snapshotValue?["singleWon"] as? String ?? "No singleWon"
        singleLost = snapshotValue?["singleLost"] as? String ?? "No singleLost"
        scoreChallenge = snapshotValue?["scoreChallenge"] as? String ?? "No scoreChallenge"
        scoreMultiplayer = snapshotValue?["scoreMultiplayer"] as? String ?? "No scoreMultiplayer"
    }
    
    func serialize() -> [String:Any] {
        return  ["id": id, "username": username, "email": email, "profilePic": profilePic, "scoreSingle": scoreSingle, "singleWon": singleWon, "singleLost": singleLost, "scoreChallenge": scoreChallenge, "scoreMultiplayer": scoreMultiplayer]
    }
    
    func deserialize(_ data: [String : Any]) -> User {
        let id = data["id"] as? String ?? ""
        let username = data["username"] as? String ?? ""
        let email = data["email"] as? String ?? ""
        let profilePic = data["profilePic"] as? String ?? ""
        let scoreSingle = data["scoreSingle"] as? String ?? ""
        let singleWon = data["singleWon"] as? String ?? ""
        let singleLost = data["singleLost"] as? String ?? ""
        let scoreChallenge = data["scoreChallenge"] as? String ?? ""
        let scoreMultiplayer = data["scoreMultiplayer"] as? String ?? ""

        return User(id: id, username: username, email: email, profilePic: profilePic, scoreSingle: scoreSingle, singleWon: singleWon, singleLost: singleLost, scoreChallenge: scoreChallenge, scoreMultiplayer: scoreMultiplayer)
    }
}
