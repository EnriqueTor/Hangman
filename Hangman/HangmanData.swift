//
//  HangmanData.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/16/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import Foundation

class HangmanData {
    
    // MARK: - Properties
    
    static let sharedInstance = HangmanData()
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Methods
    
    func getWordFromAPI(completion: @escaping ([String:Any]) -> Void) {
        
        print("We are getting into the Current Data raw information")
        
        var currentWord: [String:Any] = [:]
        
        HangmanAPI.getHangmanWord { (JSON) in
            
            currentWord = JSON["currently"] as! [String:Any]
            
            print("9a. We just load the CURRENT DATA")
            
            completion(currentWord)
        }
    }
    
   }
