//
//  LoginViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/15/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets 
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Variables
    
    let database = FIRDatabase.database().reference()
    let store = HangmanData.sharedInstance
    let myKeychainWrapper = KeychainWrapper()
    
    // MARK: - Loads 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: Methods 
    
    func setupView() {
        
        let attr = [NSForegroundColorAttributeName: UIColor.white]
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: attr)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: attr)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        background.image = store.chalkboard
    }
    
    func login() {
        
        guard let email = emailTextField.text, let pass = passwordTextField.text else { return }
        
        if email != "" && pass != "" {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: pass) { (user, error) in
                
                if error != nil {
                    
                    let alert = UIAlertController(title: nil, message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    
                    let userData = self.database.child("users").child((user?.uid)!)
                    
                    userData.observe(.value, with: { (snapshot) in
                        let data = snapshot.value as? [String:Any]
                        let loggedUser = User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
                        
                        self.store.user = loggedUser.deserialize(data!)
                        self.addDataToKeychain(id: (user?.uid)!, name: self.store.user.username, email: email)
                        
                        NotificationCenter.default.post(name: Notification.Name.openMainVC, object: nil)
                    })
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        return true
    }
    
    func addDataToKeychain(id: String, name: String, email: String) {
        
        UserDefaults.standard.setValue(id, forKey: "id")
        UserDefaults.standard.setValue(name, forKey: "name")
        UserDefaults.standard.setValue(email, forKey: "email")
        
        myKeychainWrapper.mySetObject(passwordTextField.text, forKey:kSecValueData)
        myKeychainWrapper.writeToKeychain()
        UserDefaults.standard.synchronize()
    }

    // MARK: - Actions
    
    @IBAction func loginPushed(_ sender: UIButton) {
        login()
    }
    
    @IBAction func cancelPushed(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name.openWelcomeVC, object: nil)
    }
}
