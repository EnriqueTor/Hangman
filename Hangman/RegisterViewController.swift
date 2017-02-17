//
//  RegisterViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/15/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupView()

    }

    
    func setupView() {
        
        let attr = [NSForegroundColorAttributeName: UIColor.white]
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: attr)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: attr)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: attr)
        
        
    }
    

    @IBAction func registerPushed(_ sender: UIButton) {
        
        
    }




    @IBAction func cancelPushed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }



}
