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
    var date: String
    var status: String
    var title: String
    var rounds: String
    
    var player1Id: String
    var player1Name: String
    var player1Pic: String
    var player1Rounds: String
    var player1Points: String
    
    var player2Id: String
    var player2Name: String
    var player2Pic: String
    var player2Rounds: String
    var player2Points: String
    
    var player3Id: String
    var player3Name: String
    var player3Pic: String
    var player3Rounds: String
    var player3Points: String
    
    var player4Id: String
    var player4Name: String
    var player4Pic: String
    var player4Rounds: String
    var player4Points: String
    
    
    init(id: String, date: String, status: String, title: String, rounds: String, player1Id: String, player1Name: String, player1Pic: String, player1Rounds: String, player1Points: String, player2Id: String, player2Name: String, player2Pic: String, player2Rounds: String, player2Points: String, player3Id: String, player3Name: String, player3Pic: String, player3Rounds: String, player3Points: String, player4Id: String, player4Name: String,player4Pic: String, player4Rounds: String, player4Points: String) {
    
        
        
        self.id = id
        self.date = date
        self.status = status
        self.title = title
        self.rounds = rounds
        
        self.player1Id = player1Id
        self.player1Name = player1Name
        self.player1Pic = player1Pic
        self.player1Rounds = player1Rounds
        self.player1Points = player1Points
        
        self.player2Id = player2Id
        self.player2Name = player2Name
        self.player2Pic = player2Pic
        self.player2Rounds = player2Rounds
        self.player2Points = player2Points
        
        self.player3Id = player3Id
        self.player3Name = player3Name
        self.player3Pic = player3Pic
        self.player3Rounds = player3Rounds
        self.player3Points = player3Points
        
        self.player4Id = player4Id
        self.player4Name = player4Name
        self.player4Pic = player4Pic
        self.player4Rounds = player4Rounds
        self.player4Points = player4Points
        
    }
    
    init(snapshot: FIRDataSnapshot) {
        
        let snapshotValue = snapshot.value as? [String : Any]
        
        id = snapshotValue?["id"] as? String ?? "No id"
        date = snapshotValue?["date"] as? String ?? "No date"
        status = snapshotValue?["status"] as? String ?? "No status"
        title = snapshotValue?["title"] as? String ?? "No title"
        rounds = snapshotValue?["rounds"] as? String ?? "No points"

        player1Id = snapshotValue?["player1Id"] as? String ?? "no id"
        player1Name = snapshotValue?["player1Name"] as? String ?? "no name"
        player1Pic = snapshotValue?["player1Pic"] as? String ?? "no pic"
        player1Rounds = snapshotValue?["player1Rounds"] as? String ?? "no rounds"
        player1Points = snapshotValue?["player1Points"] as? String ?? "no points"
        
        player2Id = snapshotValue?["player2Id"] as? String ?? "no id"
        player2Name = snapshotValue?["player2Name"] as? String ?? "no name"
        player2Pic = snapshotValue?["player2Pic"] as? String ?? "no pic"
        player2Rounds = snapshotValue?["player2Rounds"] as? String ?? "no rounds"
        player2Points = snapshotValue?["player2Points"] as? String ?? "no points"
        
        player3Id = snapshotValue?["player3Id"] as? String ?? "no id"
        player3Name = snapshotValue?["player3Name"] as? String ?? "no name"
        player3Pic = snapshotValue?["player3Pic"] as? String ?? "no pic"
        player3Rounds = snapshotValue?["player3Rounds"] as? String ?? "no rounds"
        player3Points = snapshotValue?["player3Points"] as? String ?? "no points"
        
        player4Id = snapshotValue?["player4Id"] as? String ?? "no id"
        player4Name = snapshotValue?["player4Name"] as? String ?? "no name"
        player4Pic = snapshotValue?["player4Pic"] as? String ?? "no pic"
        player4Rounds = snapshotValue?["player4Rounds"] as? String ?? "no rounds"
        player4Points = snapshotValue?["player4Points"] as? String ?? "no points"
        
        }
    
    func serialize() -> [String:Any] {
        
        return  ["id": id, "date": date, "status": status, "title": title, "rounds": rounds, "player1Id": player1Id, "player1Name": player1Name, "player1Pic": player1Pic, "player1Roudns": player1Rounds, "player1Points": player1Points, "player2": player2Id, "player2Name": player2Name, "player2Pic": player2Pic, "player2Rounds": player2Rounds,"player2Points": player2Points, "player3Id": player3Id, "player3Name": player3Name, "player3Pic": player3Pic, "player3Roudns": player3Rounds, "player3Points": player3Points, "player4Id": player4Id, "player4Name": player4Name, "player4Pic": player4Pic, "player4Roudns": player4Rounds, "player4Points": player4Points]
    }
    
    func deserialize(_ data: [String : Any]) -> GroupGame {
        
        let id = data["id"] as? String ?? ""
        let date = data["date"] as? String ?? ""
        let status = data["status"] as? String ?? ""
        let title = data["title"] as? String ?? ""
        let rounds = data["rounds"] as? String ?? ""
        
        let player1Id = data["player1Id"] as? String ?? ""
        let player1Name = data["player1Name"] as? String ?? ""
        let player1Pic = data["player1Pic"] as? String ?? ""
        let player1Rounds = data["player1Rounds"] as? String ?? ""
        let player1Points = data["player1Points"] as? String ?? ""
        
        let player2Id = data["player2Id"] as? String ?? ""
        let player2Name = data["player2Name"] as? String ?? ""
        let player2Pic = data["player2Pic"] as? String ?? ""
        let player2Rounds = data["player2Rounds"] as? String ?? ""
        let player2Points = data["player2Points"] as? String ?? ""
        
        let player3Id = data["player3Id"] as? String ?? ""
        let player3Name = data["player3Name"] as? String ?? ""
        let player3Pic = data["player3Pic"] as? String ?? ""
        let player3Rounds = data["player3Rounds"] as? String ?? ""
        let player3Points = data["player3Points"] as? String ?? ""
        
        let player4Id = data["player4Id"] as? String ?? ""
        let player4Name = data["player4Name"] as? String ?? ""
        let player4Pic = data["player4Pic"] as? String ?? ""
        let player4Rounds = data["player4Rounds"] as? String ?? ""
        let player4Points = data["player4Points"] as? String ?? ""
        
        return GroupGame(id: id, date: date, status: status, title: title, rounds: rounds, player1Id: player1Id, player1Name: player1Name, player1Pic: player1Pic, player1Rounds: player1Rounds, player1Points: player1Points, player2Id: player2Id, player2Name: player2Name, player2Pic: player2Pic, player2Rounds: player2Rounds, player2Points: player2Points, player3Id: player3Id, player3Name: player3Name, player3Pic: player3Pic, player3Rounds: player3Rounds, player3Points: player3Points, player4Id: player4Id, player4Name: player4Name, player4Pic: player4Pic, player4Rounds: player4Rounds, player4Points: player4Points)
    }
}
