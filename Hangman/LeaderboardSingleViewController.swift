//
//  LeaderboardSingleViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/17/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class LeaderboardSingleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Outlets 
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var singleButton: UITabBarItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPoints: UILabel!
    @IBOutlet weak var userPosition: UILabel!
    
    // MARK: - Variables
    
    let store = HangmanData.sharedInstance
    let database = FIRDatabase.database().reference()
    var userSimplePosition = String()
    
    // MARK: - Loads 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        retrieveUserPoints()
        background.image = store.chalkboard
        tabBarController?.tabBar.transparentNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // MARK: - Methods
    
    /* This methods brings the image, position, name and points of any user selected. */
    func retrieveUserInfo(url: String, image: UIImageView, position: String, name: String, points: String) {
        
        let profileImgUrl = URL(string: url)
        
        image.contentMode = .scaleAspectFill
        image.setRounded()
        image.clipsToBounds = true
        image.sd_setImage(with: profileImgUrl)
        
        userPosition.text = position + "."
        userName.text = name
        userPoints.text = points
    }
    
    /* This method retrieve the users of the single games and order them from higher to lower accordingly to their points. */
    func retrieveUserPoints() {
        
        database.child("leaderboardSingle").observe(.value, with: { (snapshot) in
            
            if snapshot.exists() == false {
                
            } else {
                
                guard let data = snapshot.value as? [String : String] else { return }
                
                var key = Array(data.keys)
                
                key.sort { (o1, o2) -> Bool in
                    
                    return Int32(data[o1]!)! > Int32(data[o2]!)!
                }
                
                self.store.leaderboardSingle = key
                
                if let position = self.store.leaderboardSingle.index(where: {$0 == self.store.user.id}) {
                    
                    self.userSimplePosition = "\(Int(position) + 1)" ?? "?"
                    self.retrieveUserInfo(url: self.store.user.profilePic, image: self.userPic, position: self.userSimplePosition, name: self.store.user.username, points: self.store.user.scoreSingle)
                    self.tableView.reloadData()
                    
                } else {
                    
                    self.retrieveUserInfo(url: self.store.user.profilePic, image: self.userPic, position: "???", name: self.store.user.username, points: "???")
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    // MARK: - Methods TableView
    
    /* This assign the amount of rows the tableView is going to have. */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.store.leaderboardSingle.count
    }
    
    /* This method takes the userID and retrieved their data to display in the tableView. */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* Select the cell */
        let cell = tableView.dequeueReusableCell(withIdentifier: "singleCell", for: indexPath) as! SingleTableViewCell
        
        /* Select the user */
        var user = self.store.leaderboardSingle[indexPath.row]
        
        /* Retrieve the user data */
        self.database.child("users").child(user).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let data = snapshot.value as? [String:Any]
            let user = User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
            var userSelected = user.deserialize(data!)
            
            DispatchQueue.main.async {
                
                /* Display the user data */
                cell.retrieveUserInfo(url: userSelected.profilePic, image: cell.userPic, position: indexPath.row + 1, name: userSelected.username, points: userSelected.scoreSingle)
                
                cell.backgroundColor = UIColor.clear
                cell.selectionStyle = .none
            }
        })
        
        return cell
    }
}

class SingleTableViewCell: UITableViewCell {

    // MARK: - Outlets 
    
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPoints: UILabel!
    @IBOutlet weak var userPosition: UILabel!
    
    // MARK: - Methods 
    
    /* Same explanation than above */
    func retrieveUserInfo(url: String, image: UIImageView, position: Int, name: String, points: String) {
        
        let profileImgUrl = URL(string: url)
        
        image.contentMode = .scaleAspectFill
        image.setRounded()
        image.clipsToBounds = true
        image.sd_setImage(with: profileImgUrl)
        
        userPosition.text = "\(position)."
        userName.text = name
        userPoints.text = points
    }
}
