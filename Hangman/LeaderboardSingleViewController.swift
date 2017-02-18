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

class LeaderboardSingleViewController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var singleButton: UITabBarItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userPic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userPoints: UILabel!
    
    
    
    
    
    let store = HangmanData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
}
