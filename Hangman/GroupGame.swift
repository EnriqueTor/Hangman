//
//  GroupGame.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/20/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import Foundation
import Firebase

struct GroupGame {
    
    var id: String
    var player1: User
    var player2: User
    var player3: User
    var player4: User
    var date: String
    var status: String
    var title: String
    var words: String
    
    init(id: String, player1: User, player2: User, player3: User, player4: User, date: String, status: String, title: String, words: String) {
        
        self.id = id
        self.player1 = player1
        self.player2 = player2
        self.player3 = player3
        self.player4 = player4
        self.date = date
        self.status = status
        self.title = title
        self.words = words
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        let snapshotValue = snapshot.value as? [String : Any]
        
        id = snapshotValue?["id"] as? String ?? "No id"
        player1 = snapshotValue?["player1"] as? User ?? User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        player2 = snapshotValue?["player2"] as? User ?? User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        player3 = snapshotValue?["player3"] as? User ?? User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        player4 = snapshotValue?["player4"] as? User ?? User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        date = snapshotValue?["date"] as? String ?? "No date"
        status = snapshotValue?["status"] as? String ?? "No status"
        title = snapshotValue?["title"] as? String ?? "No title"
        words = snapshotValue?["words"] as? String ?? "No words"
    }
    
    func serialize() -> [String:Any] {
        
        return  ["id": id, "player1": player1.id, "player2": player2.id, "player3": player3.id, "player4": player4.id, "date": date, "status": status, "title": title, "words": words]
    }
    
    func deserialize(_ data: [String : Any]) -> GroupGame {
        
        let id = data["id"] as? String ?? ""
        let player1 = data["player1"] as? User ?? User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        let player2 = data["player2"] as? User ?? User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        let player3 = data["player3"] as? User ?? User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        let player4 = data["player4"] as? User ?? User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        let date = data["date"] as? String ?? ""
        let status = data["status"] as? String ?? ""
        let title = data["title"] as? String ?? ""
        let words = data["words"] as? String ?? ""
        
        return GroupGame(id: id, player1: player1, player2: player2, player3: player3, player4: player4, date: date, status: status, title: title, words: words)
    }
}
