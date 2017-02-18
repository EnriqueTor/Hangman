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
    var singleScore: String
    var challengeScore: String
    var multiplayerScore: String
    
    init(id: String, username: String, email: String, profilePic: String, singleScore: String, challengeScore: String, multiplayerScore: String) {
        
        self.id = id
        self.username = username
        self.email = email
        self.profilePic = profilePic
        self.singleScore = singleScore
        self.challengeScore = challengeScore
        self.multiplayerScore = multiplayerScore
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as? [String : Any]
        
        id = snapshotValue?["id"] as? String ?? "No id"
        username = snapshotValue?["username"] as? String ?? "No username"
        email = snapshotValue?["email"] as? String ?? "No email"
        profilePic = snapshotValue?["profilePic"] as? String ?? "No profile pic"
        singleScore = snapshotValue?["singleScore"] as? String ?? "No singleScore"
        challengeScore = snapshotValue?["challengeScore"] as? String ?? "No challengeScore"
        multiplayerScore = snapshotValue?["multiplayerScore"] as? String ?? "No multiplayerScore"
    }
    
    func serialize() -> [String:Any] {
        return  ["id": id, "username": username, "email": email, "profilePic": profilePic, "singleScore": singleScore, "challengeScore": challengeScore, "multiplayerScore": multiplayerScore]
    }
    
    func deserialize(_ data: [String : Any]) -> User {
        let id = data["id"] as? String ?? ""
        let username = data["username"] as? String ?? ""
        let email = data["email"] as? String ?? ""
        let profilePic = data["profilePic"] as? String ?? ""
        let singleScore = data["singleScore"] as? String ?? ""
        let challengeScore = data["challengeScore"] as? String ?? ""
        let multiplayerScore = data["multiplayerScore"] as? String ?? ""

        return User(id: id, username: username, email: email, profilePic: profilePic, singleScore: singleScore, challengeScore: challengeScore, multiplayerScore: multiplayerScore)
    }
    
}
