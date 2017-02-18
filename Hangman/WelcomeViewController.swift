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
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var hLabel: UILabel!
    @IBOutlet weak var a1Label: UILabel!
    @IBOutlet weak var n1Label: UILabel!
    @IBOutlet weak var gLabel: UILabel!
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var a2Label: UILabel!
    @IBOutlet weak var n2Label: UILabel!
    
    let myKeychainWrapper = KeychainWrapper()
    let database = FIRDatabase.database().reference()
    let store = HangmanData.sharedInstance
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func introAnimation() {
        
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.a1Label.isHidden = false
            self.a2Label.isHidden = false
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            
            self.n1Label.isHidden = false
            self.n2Label.isHidden = false
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            
            self.gLabel.isHidden = false
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            
            self.hLabel.isHidden = false
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            self.mLabel.isHidden = false
            self.welcome()
        })
    }
    
    
    @IBAction func loginPushed(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Notification.Name.openLoginVC, object: nil)
        
        
    }
    
    
    @IBAction func registerPushed(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Notification.Name.openRegisterVC, object: nil)
        
        
    }
    
    func welcome() {
        
        if UserDefaults.standard.value(forKey: "email") as? String == nil {
            
            loginButton.isHidden = false
            registerButton.isHidden = false
            
        }
            
        else {
            
            let email = UserDefaults.standard.value(forKey: "email") as? String
            let pass = myKeychainWrapper.myObject(forKey: "v_Data") as? String
            
            FIRAuth.auth()?.signIn(withEmail: email!, password: pass!) { (user, error) in
                
                if error != nil {
                    
                }
                    
                else {
                    
                    let userData = self.database.child("users").child((user?.uid)!)
                    
                    // update daily list
                    
                    userData.observe(.value, with: { (snapshot) in
                        
                        let data = snapshot.value as? [String:Any]
                        let loggedUser = User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
                        
                        self.store.user = loggedUser.deserialize(data!)
                        
                        NotificationCenter.default.post(name: Notification.Name.openMainVC, object: nil)
                        
                    })
                }
            }
        }
    }
}

