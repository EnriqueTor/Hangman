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
import SDWebImage

class SettingsViewController: UIViewController, MFMailComposeViewControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: - Outlets 
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var userTextField: UITextField!
    
    // MARK: - Variables
    
    let database = FIRDatabase.database().reference()
    let store = HangmanData.sharedInstance
    
    // MARK: - Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.image = store.chalkboard
        self.title = "SETTINGS"
        userTextField.delegate = self
        retrieveUserInfo(url: store.user.profilePic, image: userProfile, name: store.user.username)
    }
    
    
    // MARK: Methods
    
    /* This method will open the Mail ViewController so the user can send some feedback */
    func sendEmail() {
        
        if MFMailComposeViewController.canSendMail() {
            
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["etorrendell@gmail.com"])
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

    /* This method retrieves the user data and image using the SDWebImage framework */
    func retrieveUserInfo(url: String, image: UIImageView, name: String) {
        
        let profileImgUrl = URL(string: url)
        
        userProfile.contentMode = .scaleAspectFill
        userProfile.setRounded()
        userProfile.clipsToBounds = true
        
        DispatchQueue.main.async {
            
            self.userProfile.sd_setImage(with: profileImgUrl)
            self.userTextField.text = name
        }
    }
    
    // MARK: Methods 
    
    /* This is the same integration than the one in register View Controller */
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
            
            DispatchQueue.main.async {
                self.userProfile.image = image
            }
            
            userProfile.clipsToBounds = true
            userProfile.contentMode = .scaleAspectFill
            
            userProfile.setRounded()
            saveProfileImage()
            
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
            
            guard let uploadData = UIImageJPEGRepresentation(self.userProfile.image!, 0.20) else { return }
            
            storageImageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    return
                }
                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
                
                self.database.child("users").child(self.store.user.id).child("profilePic").setValue(profileImageUrl)
                self.store.user.profilePic = profileImageUrl
            })
        }
    }
    
    /* When the user hits return the new name gets saved in Firebase and in the Hangman Data store */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.store.user.username = userTextField.text!
        self.database.child("users").child(self.store.user.id).child("username").setValue(self.userTextField.text)

        userTextField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        return true
    }
    
    /* This method delete the keys from UserDefaults and log you out of Firebase. Once than it takes you to the Welcome View Controller */
    func logout() {
        
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
    
    // MARK: - Actions
    
    @IBAction func changePicturePushed(_ sender: UITapGestureRecognizer) {
        
        pickPhotoFromAlbum()
    }
    
    @IBAction func sendEmail(_ sender: UIButton) {
        
        sendEmail()
    }
    
    @IBAction func logoutPushed(_ sender: UIButton) {
        
        logout()
    }
    
    @IBAction func setChalkboardGreen(_ sender: UIButton) {
        store.chalkboard = UIImage(named: "ChalkboardGreen")
        store.smallChalkboard = UIImage(named: "ChalkboardGreenOption")
        UserDefaults.standard.setValue("board", forKey: "ChalkboardGreen")
        background.image = store.chalkboard
    }
    
    @IBAction func setChalkboardGray(_ sender: UIButton) {
        store.chalkboard = UIImage(named: "Chalkboard")
        store.smallChalkboard = UIImage(named: "ChalkboardBlackOption")
        UserDefaults.standard.setValue("board", forKey: "Chalkboard")
        background.image = store.chalkboard
    }
    
    @IBAction func setChalkboardBlue(_ sender: UIButton) {
        store.chalkboard = UIImage(named: "ChalkboardBlue")
        store.smallChalkboard = UIImage(named: "ChalkboardBlueOption")
        UserDefaults.standard.setValue("board", forKey: "ChalkboardBlue")
        background.image = store.chalkboard
    }
}
