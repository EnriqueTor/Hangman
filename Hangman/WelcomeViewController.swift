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
    
    let myKeychainWrapper = KeychainWrapper()
//    let database = FIRDatabase.database().reference()
    let store = HangmanData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
           welcome()
        
        
        
        
        
    }

    
    @IBAction func loginPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "loginSegue", sender: self)
        
    }
    
    
    @IBAction func registerPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "registerSegue", sender: self)
        
    }
    
    func welcome() {
        
        func loginUser() {
            
            if UserDefaults.standard.value(forKey: "email") as? String == nil {
                
                return
                
            }
                
            else {
                
                let email = UserDefaults.standard.value(forKey: "email") as? String
                let pass = myKeychainWrapper.myObject(forKey: "v_Data") as? String
                
                FIRAuth.auth()?.signIn(withEmail: email!, password: pass!) { (user, error) in
                    
                    if error != nil {
                        
                    }
                        
                    else {
                        
//                        let userData = self.database.child("users").child((user?.uid)!)
//                        
//                        // update daily list
//                        
//                        userData.observe(.value, with: { (snapshot) in
//                            
//                            let data = snapshot.value as? [String:Any]
//                            let loggedUser = User(id: "", username: "", email: "", profilePic: "")
//                            self.store.user = loggedUser.deserialize(data!)
//                            
//                            NotificationCenter.default.post(name: Notification.Name.openMainVC, object: nil)
//                            
//                        })
                    }
                }
            }
        }

        
        
    }
    
}

