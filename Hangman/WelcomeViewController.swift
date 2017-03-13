//
//  WelcomeViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/15/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    /* The labels here are part of the logo. */
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var hLabel: UILabel!
    @IBOutlet weak var a1Label: UILabel!
    @IBOutlet weak var n1Label: UILabel!
    @IBOutlet weak var gLabel: UILabel!
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var a2Label: UILabel!
    @IBOutlet weak var n2Label: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK: - Variables
    
    /* myKychainWrapper conects the ViewController with the framework. The database is a shortcut to Firebase and store is a shortcut to HangmanData where we saved some useful data to move it though different ViewControllers. */
    let myKeychainWrapper = KeychainWrapper()
    let database = FIRDatabase.database().reference()
    let store = HangmanData.sharedInstance
    
    // MARK: - Loads
    
    /* The method on HangmanAPI download the dictionary for the game. */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let boardColor = UserDefaults.standard.value(forKey: "board") as? String {
            store.chalkboard = UIImage(named: boardColor)
        }
        background.image = store.chalkboard
        loginButton.isHidden = true
        registerButton.isHidden = true
        store.arrayOfWords.removeAll()
        HangmanAPI.getHangmanWord()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        introAnimation()
    }
    
    // MARK: - Methods
    
    /* This method does the cool efect on the logo */
    func introAnimation() {
        
        UIView.animateKeyframes(withDuration: 3.0, delay: 0.00, options: [], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.20, relativeDuration: 0.00, animations: {
                self.a1Label.alpha = 1
                self.a2Label.alpha = 1
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.40, relativeDuration: 0.00, animations: {
                self.n1Label.alpha = 1
                self.n2Label.alpha = 1
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.60, relativeDuration: 0.00, animations: {
                self.gLabel.alpha = 1
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.80, relativeDuration: 0.00, animations: {
                self.hLabel.alpha = 1
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1.00, relativeDuration: 0.00, animations: {
                self.mLabel.alpha = 1
            })
            
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.welcome()
        })
    }
    
    /* This method checks if the UserDefaults has data to see if this is a recurrent user. If it is not a recurrent user it will stop. If it is it brigns the email from UserDefaults and the password from the framework myKeychainWrapper. Then it goes to Firebase to fetch the data of the User and it jumps to the Main view using a custom Notification (AppController). */
    func welcome() {
        
        /* Checking UserDefaults */
        if UserDefaults.standard.value(forKey: "email") as? String == nil {
            
            loginButton.isHidden = false
            registerButton.isHidden = false
        }
        else {
            
            /* Fetching data from UserDefaults and myKeychainWrapper */
            let email = UserDefaults.standard.value(forKey: "email") as? String
            let pass = myKeychainWrapper.myObject(forKey: "v_Data") as? String
            
            /* Sign in to Firebase */
            FIRAuth.auth()?.signIn(withEmail: email!, password: pass!) { (user, error) in
                
                if error != nil {
                }
                else {
                    
                    let userData = self.database.child("users").child((user?.uid)!)
                    
                    /* Downloading User data */
                    userData.observe(.value, with: { (snapshot) in
                        
                        let data = snapshot.value as? [String:Any]
                        let loggedUser = User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", singleWon: "", singleLost: "", scoreChallenge: "", scoreMultiplayer: "")
                        
                        /* Store the data into our HangmanData using a custom method. */
                        self.store.user = loggedUser.deserialize(data!)
                        
                        /* Switch View Controller */
                        NotificationCenter.default.post(name: Notification.Name.openMainVC, object: nil)
                    })
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func loginPushed(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Notification.Name.openLoginVC, object: nil)
    }
    
    @IBAction func registerPushed(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Notification.Name.openRegisterVC, object: nil)
    }
}

