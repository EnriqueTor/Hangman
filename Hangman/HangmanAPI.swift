//
//  HangmanAPI.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/16/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import Foundation

class HangmanAPI {
    
    // OLD CODE
    
    // MARK: - Methods
    
    //    class func getHangmanWord(with completion: @escaping (([String]) -> Void)) {
    
        class func getHangmanWord() {
        
        let urlString = Secrets.link
        print("2. We put together the link, getting the data from Secrets")
        
        let url = URL(string: urlString)
        print("3. We transfor the string into an URL")
        
        guard let unwrappedUrl = url else { return }
        print("4. We are taking care of the optional")
        
        let session = URLSession.shared
        print("5. We created the URL session that we will use to enter the web")
        
        let task = session.dataTask(with: unwrappedUrl) { (data, response, error) in
            print("6. We are creating the constant to get the data from an URL")
            
            guard let unwrappedData = data else { return }
            print("7. We are taking care of the optional")
            
            do {
                
                let words = try String(contentsOf: unwrappedUrl)
                
                print("8a. We are accessing the raw data")
                
                HangmanData.sharedInstance.arrayOfWords = words.components(separatedBy: ["\n"])
                
                //                let wordPositionPick =
                //                print(arrayOfWords[22])
                //                completion(HangmanData.sharedInstance.arrayOfWords)
                
            } catch {
                
                print("8b. Something failed!!")
            }
        }
        task.resume()
        
    }
}
