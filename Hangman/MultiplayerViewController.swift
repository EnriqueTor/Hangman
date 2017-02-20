//
//  MultiplayerViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/19/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class MultiplayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var background: UIImageView!
    
    
    
    let store = HangmanData.sharedInstance
    let database = FIRDatabase.database().reference()
    var activeGames = [String]()
    var gameSelected = ""
    
    //    var picsStrings = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.image = store.chalkboard
        
        print("OOOOOOOOOOO")
        print(store.gameSelected)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func createGamePushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "createGameSegue", sender: self)
        
    }
    
    
    @IBAction func activeGamesPushed(_ sender: UIButton) {
        
        
    }
    
    @IBAction func archivedGamesPushed(_ sender: UIButton) {
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "multiplayerCell", for: indexPath) as! MultiplayerTableViewCell
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        let gameID = activeGames[indexPath.row]
        
        database.child("multiplayer").child(gameID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.exists() == false {
                
            } else {
                
                guard let data = snapshot.value as? [String:Any] else { return }
                
                DispatchQueue.main.async {
                    cell.gameLabel.text = data["title"] as! String?
                    cell.retrieveUserInfo(url: data["player1Pic"] as! String, image: cell.pic1)
                    cell.retrieveUserInfo(url: data["player2Pic"] as! String, image: cell.pic2)
                    cell.retrieveUserInfo(url: data["player3Pic"] as! String, image: cell.pic3)
                    cell.retrieveUserInfo(url: data["player4Pic"] as! String, image: cell.pic4)
                }
            }
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        gameSelected = activeGames[indexPath.row]
        store.gameSelected = gameSelected
        
        self.performSegue(withIdentifier: "gameInfo2Segue", sender: self)
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.identifier == "gameInfo2Segue" {
//            
//            guard let dest = segue.destination as? InfoGameViewController else { return }
//            
//            database.child("multiplayer").child(store.gameSelected).observeSingleEvent(of: .value, with: { (snapshot) in
//                
//                guard let data = snapshot.value as? [String:Any] else { return }
//                
//                dest.titleLabel.text = data["title"] as! String
//                
//                var rounds = data["words"] as! String
//                
//                dest.roundsGame.text = rounds + " ROUNDS"
//            })
//            
//            
//            
////            dest.retrieveUserPoints()
//            
//        }
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

    
}


class MultiplayerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var pic1: UIImageView!
    @IBOutlet weak var pic2: UIImageView!
    @IBOutlet weak var pic3: UIImageView!
    @IBOutlet weak var pic4: UIImageView!
    
    func retrieveUserInfo(url: String, image: UIImageView) {
        
        let profileImgUrl = URL(string: url)
        
        image.contentMode = .scaleAspectFill
        image.setRounded()
        image.clipsToBounds = true
        image.sd_setImage(with: profileImgUrl)
        
    }
    
    
}


