//
//  RegisterViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/15/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var profilePic: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupView()

    }

    
    func setupView() {
        
        let attr = [NSForegroundColorAttributeName: UIColor.white]
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "username", attributes: attr)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: attr)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: attr)
        
        profilePic.clipsToBounds = true
    }
    

    @IBAction func registerPushed(_ sender: UIButton) {
        
        
    }




    @IBAction func cancelPushed(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func profilePicPushed(_ sender: UITapGestureRecognizer) {
        
        pickPhotoFromAlbum()
        print("PROFILE PIC")
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
//        imagePicker.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Bite Chalk", size: 30)!]
        imagePicker.navigationBar.tintColor = .white

        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            profilePic.image = image
            profilePic.clipsToBounds = true
            profilePic.contentMode = .scaleAspectFill

            profilePic.setRounded()
           
//            saveProfileImage()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
//    func saveProfileImage() {
//        DispatchQueue.main.async {
//            let storageRef = FIRStorage.storage().reference(forURL: "gs://face-ba4e6.appspot.com")
//            let imageId = self.store.user.id
//            let storageImageRef = storageRef.child("profileImages").child(imageId)
//            
//            guard let uploadData = UIImageJPEGRepresentation(self.profileImage.image!, 0.20) else { return }
//            
//            storageImageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
//                if error != nil {
//                    return
//                }
//                guard let profileImageUrl = metadata?.downloadURL()?.absoluteString else { return }
//                
//                self.store.user.profilePic = profileImageUrl
//                self.database.child("users").child(self.store.user.id).child("profilePic").setValue(self.store.user.profilePic)
//            })
//            
//        }
//    }

    

}
