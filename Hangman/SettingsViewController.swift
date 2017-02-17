//
//  SettingsViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/15/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit
import Firebase
import MessageUI


class SettingsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    @IBOutlet weak var background: UIImageView!
    
    let store = HangmanData.sharedInstance
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.image = store.chalkboard
        self.title = "SETTINGS"
        
        
    }
    
    @IBAction func sendEmail(_ sender: UIButton) {
        sendEmail()
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
    
    @IBAction func setChalkboardGray(_ sender: UIButton) {
        store.chalkboard = UIImage(named: "Chalkboard")
        background.image = store.chalkboard
    }
    
    
    @IBAction func setChalkboardBlue(_ sender: UIButton) {
        
        store.chalkboard = UIImage(named: "ChalkboardBlue")
        background.image = store.chalkboard
        
    }
   
    func sendEmail() {
        
        if MFMailComposeViewController.canSendMail() {
        
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["thedocitapp@gmail.com"])
            mail.setSubject("Feedback")
            mail.setMessageBody("", isHTML: true)
            
            mail.navigationBar.tintColor = UIColor.white
            
            present(mail, animated: true)
            
        } else {
            // show failure alert
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

    
    
    
    
    
}
