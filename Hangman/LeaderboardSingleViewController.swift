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

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var singleButton: UITabBarItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPoints: UILabel!
    @IBOutlet weak var userPosition: UILabel!
    
    let store = HangmanData.sharedInstance
    let database = FIRDatabase.database().reference()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        retrieveUserPoints()
        retrieveUserPic()
        background.image = store.chalkboard
        tabBarController?.tabBar.transparentNavigationBar()
              
    }

    func retrieveUserPic() {
        
        let profileImgUrl = URL(string: store.user.profilePic)
        
        userPic.contentMode = .scaleAspectFill
        userPic.setRounded()
        userPic.clipsToBounds = true
        userPic.sd_setImage(with: profileImgUrl)

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "singleCell", for: indexPath)
        
        
        
        
        
        
        
        
        return cell
        
    }
    
    func retrieveUserPoints() {
        
        database.child("leaderboardSingle").observe(.value, with: { (snapshot) in
            
            guard let userPoints = snapshot.value as? [String : Any] else { return }
            
            self.store.leaderboardSingle = userPoints
            
            print(self.store.leaderboardSingle)

        })
    }
    
}

class SingleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPoints: UILabel!
    @IBOutlet weak var userPosition: UILabel!
    
    
}
