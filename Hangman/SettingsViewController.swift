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

    
    @IBOutlet weak var background: UIImageView!

    let store = HangmanData.sharedInstance
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        background.image = store.chalkboard
    
    
    
    }
    
    

   
    @IBAction func logoutPushed(_ sender: UIButton) {
        
        do {
            try FIRAuth.auth()?.signOut()
            UserDefaults.standard.setValue(nil, forKey: "id")
            UserDefaults.standard.setValue(nil, forKey: "name")
            UserDefaults.standard.setValue(nil, forKey: "email")
     
            dismiss(animated: true, completion: nil)
            dismiss(animated: true, completion: nil)
            
            NotificationCenter.default.post(name: .openWelcomeVC, object: nil)
            
        } catch let signOutError as NSError {
            
        
    }

        
        
    }
    
    
    @IBAction func setChalkboardGreen(_ sender: UIButton) {
        
        store.chalkboard = UIImage(named: "ChalkboardGreen")
        background.image = store.chalkboard
    }
    
    
    
    
    @IBAction func backPushed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
}
