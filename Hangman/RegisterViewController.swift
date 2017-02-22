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
    
    // MARK: - Outlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var background: UIImageView!
    
    // MARK: - Variables
    
    let store = HangmanData.sharedInstance
    let database = FIRDatabase.database().reference()
    let myKeychainWrapper = KeychainWrapper()
    
    
    // MARK: - Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: Methods
    
    func setupView() {
        
        /* Same method than in LoginViewController */

        let attr = [NSForegroundColorAttributeName: UIColor.white]
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: attr)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: attr)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: attr)
        
        profilePic.clipsToBounds = true
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        background.image = store.chalkboard
    }
    
   /* This method grab the information in the textfields and create a user in Firebase. */
    
    func register() {
        
        /* Grab data. */
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let username = usernameTextField.text else { return }
        
        /* Create User. */

        FIRAuth.auth()?.createUser(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                
                let alert = UIAlertController(title: nil, message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                /* Save into UserDefaults and myKeychainWrapper */

                self.addDataToKeychain(id: (user?.uid)!, name: username, email: email)
                
                /* Run the signIn method */
                
                self.signIn()
            }
        }
    }
    
    /* Same method than in LoginViewController, the big difference is the method saveProfileImage. */
    
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
                        
                        let newUser = User(id: (user?.uid)!, username: (user?.displayName)!, email: email, profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
                        
                        self.store.user = newUser
                        self.database.child("users").child((user?.uid)!).setValue(newUser.serialize())
                        self.database.child("username").child(self.store.user.username).setValue(self.store.user.id)
                        
                        self.saveProfileImage()
                        
                        NotificationCenter.default.post(name: Notification.Name.openMainVC, object: nil)
                    }
                }
            }
        }
    }
    
    /* Same method than in LoginViewController */
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        usernameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        return true
    }
    
    /* Same method than in LoginViewController */
    
    func addDataToKeychain(id: String, name: String, email: String) {
        
        UserDefaults.standard.setValue(id, forKey: "id")
        UserDefaults.standard.setValue(name, forKey: "name")
        UserDefaults.standard.setValue(email, forKey: "email")
        
        myKeychainWrapper.mySetObject(passwordTextField.text, forKey:kSecValueData)
        myKeychainWrapper.writeToKeychain()
        UserDefaults.standard.synchronize()
    }
    
    // MARK: Methods Picker
    
    /* This method runs the method that opens our Photo Library. */
    
    func pickPhotoFromAlbum() {
        
        presentPicker(withSourceType: .photoLibrary)
    }
    
    /* This handles all the design of the picker where we will pick the picture for our profile. */

    func presentPicker(withSourceType source: UIImagePickerControllerSourceType){
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        imagePicker.sourceType = source
        imagePicker.navigationBar.barStyle = .blackTranslucent
        imagePicker.navigationBar.isTranslucent = true
        imagePicker.navigationBar.tintColor = .white
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    /* This methods close the picker and grab the image selected. */

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            profilePic.image = image
            profilePic.clipsToBounds = true
            profilePic.contentMode = .scaleAspectFill
            
            /* This is a custom method to round the images borders. */

            profilePic.setRounded()
            
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    /* It dismiss the picker if we press the cancel button. */

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
    /* This method saves the image selected into the Firebase Storage. We use the framework SDWebImage to compress the image before uploading it. We also get a string with the URL to that image. Once done we save that URL String into Firebase. */
    
    func saveProfileImage() {
        
        DispatchQueue.main.async {
        
            /* Link with Firebase Storage */

            let storageRef = FIRStorage.storage().reference(forURL: "gs://face-ba4e6.appspot.com")
            let imageId = self.store.user.id
            let storageImageRef = storageRef.child("profileImages").child(imageId)
            
            /* Get the compress image */

            guard let uploadData = UIImageJPEGRepresentation(self.profilePic.image!, 0.20) else { return }
            
            /* Save it in Firebase Storage */

            storageImageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    return
                }

                /* Get the URL String */

                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
                
                /* Save the URL String into our local HangmanData and Firebase. */

                self.store.user.profilePic = profileImageUrl
                self.database.child("users").child(self.store.user.id).child("profilePic").setValue(self.store.user.profilePic)
            })
        }
    }
    
    // MARK: - Actions
    
    @IBAction func registerPushed(_ sender: UIButton) {
        
        register()
        
    }
    
    @IBAction func cancelPushed(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Notification.Name.openWelcomeVC, object: nil)
    }
    
    @IBAction func profilePicPushed(_ sender: UITapGestureRecognizer) {
        
        pickPhotoFromAlbum()
    }
}
