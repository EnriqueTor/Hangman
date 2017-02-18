//
//  UserPoints.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/18/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import Foundation
import Firebase

struct UserPoints {
    
    var player: String
    var points: String
    
    
    init(player: String, points: String) {
        
        self.player = player
        self.points = points
        
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        let snapshotValue = snapshot.value as? [String : Any]
        
        player = snapshotValue?["player"] as? String ?? "No player"
        points = snapshotValue?["points"] as? String ?? "No points"
    }
    
    func serialize() -> [String:Any] {
        
        return  ["player": player, "points": points]
    }
    
    func deserialize(_ data: [String : Any]) -> UserPoints {
        
        let player = data["player"] as? String ?? ""
        let points = data["points"] as? String ?? ""
        
        return UserPoints(player: player, points: points)
    }
    
}
