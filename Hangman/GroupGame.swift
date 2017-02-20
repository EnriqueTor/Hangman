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
    var player1: String
    var player2: String
    var player3: String
    var player4: String
    var date: String
    var status: String
    var title: String
    var words: String
    
    init(id: String, player1: String, player2: String, player3: String, player4: String, date: String, status: String, title: String, words: String) {
        
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
        player1 = snapshotValue?["player1"] as? String ?? "No player"
        player2 = snapshotValue?["player2"] as? String ?? "No player"
        player3 = snapshotValue?["player3"] as? String ?? "No player"
        player4 = snapshotValue?["player4"] as? String ?? "No player"
        date = snapshotValue?["date"] as? String ?? "No date"
        status = snapshotValue?["status"] as? String ?? "No status"
        title = snapshotValue?["title"] as? String ?? "No title"
        words = snapshotValue?["words"] as? String ?? "No words"
    }
    
    func serialize() -> [String:Any] {
        
        return  ["id": id, "player1": player1, "player2": player2, "player3": player3, "player4": player4, "date": date, "status": status, "title": title, "words": words]
    }
    
    func deserialize(_ data: [String : Any]) -> GroupGame {
        
        let id = data["id"] as? String ?? ""
        let player1 = data["player1"] as? String ?? ""
        let player2 = data["player2"] as? String ?? ""
        let player3 = data["player3"] as? String ?? ""
        let player4 = data["player4"] as? String ?? ""
        let date = data["date"] as? String ?? ""
        let status = data["status"] as? String ?? ""
        let title = data["title"] as? String ?? ""
        let words = data["words"] as? String ?? ""
        
        return GroupGame(id: id, player1: player1, player2: player2, player3: player3, player4: player4, date: date, status: status, title: title, words: words)
    }
}
