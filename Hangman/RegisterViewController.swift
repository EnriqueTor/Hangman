//
//  RegisterViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/15/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profilePic: UIImageView!
    
    let store = HangmanData.sharedInstance
    let database = FIRDatabase.database().reference()
    let myKeychainWrapper = KeychainWrapper()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        
        let attr = [NSForegroundColorAttributeName: UIColor.white]
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: attr)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: attr)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: attr)
        
        profilePic.clipsToBounds = true
        
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    

    @IBAction func registerPushed(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let username = usernameTextField.text else { return }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
            
                let alert = UIAlertController(title: nil, message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            
            } else {
            
                self.addDataToKeychain(id: (user?.uid)!, name: username, email: email)
                self.signIn()
            }
        }
    }
    
    func signIn() {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let username = usernameTextField.text?.uppercased() else { return }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                
            } else {
                
                let changeRequest = user?.profileChangeRequest()
                
                changeRequest?.displayName = username
                changeRequest?.commitChanges { error in
                    
                    if let error = error {
                        
                    } else {
                        
                        let newUser = User(id: (user?.uid)!, username: (user?.displayName)!, email: email, profilePic: "")
                        
                        self.store.user = newUser
                        self.database.child("users").child((user?.uid)!).setValue(newUser.serialize())
                        
                        self.saveProfileImage()
                        
                        self.performSegue(withIdentifier: "mainSegue2", sender: self)
                        
                    }
                }
            }
        }
    }
    

    func addDataToKeychain(id: String, name: String, email: String) {
        UserDefaults.standard.setValue(id, forKey: "id")
        UserDefaults.standard.setValue(name, forKey: "name")
        UserDefaults.standard.setValue(email, forKey: "email")
        
        myKeychainWrapper.mySetObject(passwordTextField.text, forKey:kSecValueData)
        myKeychainWrapper.writeToKeychain()
        UserDefaults.standard.synchronize()
    }




    @IBAction func cancelPushed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func profilePicPushed(_ sender: UITapGestureRecognizer) {
        
        pickPhotoFromAlbum()
    }

    
    func pickPhotoFromAlbum() {

        presentPicker(withSourceType: .photoLibrary)
    }
    
    func presentPicker(withSourceType source: UIImagePickerControllerSourceType){
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = source
        imagePicker.navigationBar.barStyle = .blackTranslucent
        imagePicker.navigationBar.isTranslucent = true
        imagePicker.navigationBar.tintColor = .white

        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            profilePic.image = image
            profilePic.clipsToBounds = true
            profilePic.contentMode = .scaleAspectFill

            profilePic.setRounded()
        
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func saveProfileImage() {
        
        DispatchQueue.main.async {
            let storageRef = FIRStorage.storage().reference(forURL: "gs://face-ba4e6.appspot.com")
            let imageId = self.store.user.id
            let storageImageRef = storageRef.child("profileImages").child(imageId)
            
            guard let uploadData = UIImageJPEGRepresentation(self.profilePic.image!, 0.20) else { return }
            
            storageImageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    return
                }
                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
                
                self.store.user.profilePic = profileImageUrl
                self.database.child("users").child(self.store.user.id).child("profilePic").setValue(self.store.user.profilePic)
            })
            
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }

}
