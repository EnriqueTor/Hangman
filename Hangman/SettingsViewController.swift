//
//  SettingsViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/15/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
    
    
    }

   
    @IBAction func logoutPushed(_ sender: UIButton) {
        
        do {
            try FIRAuth.auth()?.signOut()
            UserDefaults.standard.setValue(nil, forKey: "id")
            UserDefaults.standard.setValue(nil, forKey: "name")
            UserDefaults.standard.setValue(nil, forKey: "email")
     
            dismiss(animated: true, completion: nil)
            dismiss(animated: true, completion: nil)
            
//            NotificationCenter.default.post(name: .openWelcomeVC, object: nil)
            
        } catch let signOutError as NSError {
            
        
    }

        
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
