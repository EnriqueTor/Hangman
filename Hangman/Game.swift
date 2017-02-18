//
//  Game.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/17/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import Foundation
import Firebase

struct Game {
    
    var id: String
    var player: String
    var type: String
    var date: String
    var result: String
    var score: String
    var lives: String
    
    init(id: String, player: String, type: String, date: String, result: String, score: String, lives: String) {
        
        self.id = id
        self.player = player
        self.type = type
        self.date = date
        self.result = result
        self.score = score
        self.lives = lives
        
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        let snapshotValue = snapshot.value as? [String : Any]
        
        id = snapshotValue?["id"] as? String ?? "No id"
        player = snapshotValue?["player"] as? String ?? "No player"
        type = snapshotValue?["type"] as? String ?? "No type"
        date = snapshotValue?["date"] as? String ?? "No date"
        result = snapshotValue?["result"] as? String ?? "No result"
        score = snapshotValue?["score"] as? String ?? "No score"
        lives = snapshotValue?["lives"] as? String ?? "No lives"
    }
    
    func serialize() -> [String:Any] {
        
        return  ["id": id, "player": player, "type": type, "date": date, "result": result, "score": score, "lives": lives]
    }
    
    func deserialize(_ data: [String : Any]) -> Game {
        
        let id = data["id"] as? String ?? ""
        let player = data["player"] as? String ?? ""
        let type = data["type"] as? String ?? ""
        let date = data["date"] as? String ?? ""
        let result = data["result"] as? String ?? ""
        let score = data["score"] as? String ?? ""
        let lives = data["lives"] as? String ?? ""
        
        return Game(id: id, player: player, type: type, date: date, result: result, score: score, lives: lives)
    }
    
}
