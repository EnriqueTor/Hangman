//
//  MainViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/15/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController, UINavigationControllerDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var challengeButton: UIButton!
    @IBOutlet weak var multiplayerButton: UIButton!
    
    // MARK: - Variables
    
    let store = HangmanData.sharedInstance
    let database = FIRDatabase.database().reference()
    
    // MARK: - Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()

        background.image = store.chalkboard
        self.navigationController?.navigationBar.transparentNavigationBar()
        self.title = "HANGMAN"
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
        self.background.image = self.store.chalkboard
        }
    }
    
    // MARK: - Methods
    
    /* This method pass the type of Game to the next View Controller */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "playSegue" {
            
            guard let dest = segue.destination as? GameViewController else { return }
            dest.typeOfGame = "SINGLE"
        }
        
        if segue.identifier == "challengeSegue" {
            
            guard let dest = segue.destination as? GameViewController else { return }
            dest.typeOfGame = "CHALLENGE"
        }
    }
    
    /* This grab today's date */
    func getDate(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: date).uppercased()
    }

    // MARK: - Actions
    
    /* This method checks if the user already played the challenge of the day, if he did then it segues to message, if he didn't it goes to the challenge of the day */
    @IBAction func challengePushed(_ sender: UIButton) {
        
        self.database.child("playedChallenge").child(self.store.user.id).child(getDate(date: Date())).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.exists() == true {
                
                self.performSegue(withIdentifier: "messageSegue", sender: self)
            }
            else {
                
                self.performSegue(withIdentifier: "challengeSegue", sender: self)
            }
        })
    }
    
    @IBAction func settingsPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "settingsSegue", sender: self)
    }

    @IBAction func leaderboardPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "leaderboardSegue", sender: self)
    }
    
    @IBAction func multiplayerPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "multiplayerSegue", sender: self)
    }
  
    @IBAction func playPushed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "playSegue", sender: self)
    }
    
}
