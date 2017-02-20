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
    var player1Pic: String
    var player2: User
    var player2Pic: String
    var player3: User
    var player3Pic: String
    var player4: User
    var player4Pic: String
    var date: String
    var status: String
    var title: String
    var words: String
    
    init(id: String, player1: User, player1Pic: String, player2: User, player2Pic: String, player3: User, player3Pic: String, player4: User, player4Pic: String, date: String, status: String, title: String, words: String) {
        
        self.id = id
        self.player1 = player1
        self.player1Pic = player1Pic
        self.player2 = player2
        self.player2Pic = player2Pic
        self.player3 = player3
        self.player3Pic = player3Pic
        self.player4 = player4
        self.player4Pic = player4Pic
        self.date = date
        self.status = status
        self.title = title
        self.words = words
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        let snapshotValue = snapshot.value as? [String : Any]
        
        id = snapshotValue?["id"] as? String ?? "No id"
        player1 = snapshotValue?["player1"] as? User ?? User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        player1Pic = snapshotValue?["player1"] as? String ?? "no pic"
        player2 = snapshotValue?["player2"] as? User ?? User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        player2Pic = snapshotValue?["player2"] as? String ?? "no pic"
        player3 = snapshotValue?["player3"] as? User ?? User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        player3Pic = snapshotValue?["player3"] as? String ?? "no pic"
        player4 = snapshotValue?["player4"] as? User ?? User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        player4Pic = snapshotValue?["player4"] as? String ?? "no pic"
        date = snapshotValue?["date"] as? String ?? "No date"
        status = snapshotValue?["status"] as? String ?? "No status"
        title = snapshotValue?["title"] as? String ?? "No title"
        words = snapshotValue?["words"] as? String ?? "No words"
    }
    
    func serialize() -> [String:Any] {
        
        return  ["id": id, "player1": player1.id, "player1Pic": player1Pic, "player2": player2.id, "player2Pic": player2Pic, "player3": player3.id, "player3Pic": player3Pic, "player4": player4.id, "player4Pic": player4Pic, "date": date, "status": status, "title": title, "words": words]
    }
    
    func deserialize(_ data: [String : Any]) -> GroupGame {
        
        let id = data["id"] as? String ?? ""
        let player1 = data["player1"] as? User ?? User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        let player1Pic = data["player1Pic"] as? String ?? ""
        let player2 = data["player2"] as? User ?? User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        let player2Pic = data["player2Pic"] as? String ?? ""

        let player3 = data["player3"] as? User ?? User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        let player3Pic = data["player3Pic"] as? String ?? ""

        let player4 = data["player4"] as? User ?? User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
        let player4Pic = data["player4Pic"] as? String ?? ""

        let date = data["date"] as? String ?? ""
        let status = data["status"] as? String ?? ""
        let title = data["title"] as? String ?? ""
        let words = data["words"] as? String ?? ""
        
        return GroupGame(id: id, player1: player1, player1Pic: player1Pic, player2: player2, player2Pic: player2Pic, player3: player3, player3Pic: player3Pic, player4: player4, player4Pic: player4Pic, date: date, status: status, title: title, words: words)
    }
}
