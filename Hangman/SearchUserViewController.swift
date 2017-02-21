//
//  SearchUserViewController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/19/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class SearchTableViewController: UITableViewController {
    
    // MARK: - Variables
    
    let database = FIRDatabase.database().reference()
    var usernames = [String]()
    var allUsers = [String : String]()
    var filteredUsernames = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    let store = HangmanData.sharedInstance
    var selectedUserID = String()
    var selectedUser: User!
    
    // MARK: - Loads
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllUsers()
        self.tableView.backgroundView = UIImageView(image: store.chalkboard)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupSearchController()
    }
    
    // MARK: - Methods
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func filterContentForSearchText(searchText: String) {
        filteredUsernames = usernames.filter { username in
            return username.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func fetchAllUsers() {
        
        usernames.removeAll()
        database.child("username").queryOrderedByKey().observeSingleEvent(of: .value, with: {snapshot in
            guard let dict = snapshot.value as? [String: Any] else { return }
            
            self.allUsers = dict as! [String : String]
            
            for (key, _) in self.allUsers {
                self.usernames.append(key)
            }
            
            self.tableView.reloadData()
        })
    }
    
    // MARK: - TableView Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != nil {
            return filteredUsernames.count
        } else {
            return usernames.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        
        cell.backgroundColor = UIColor.clear

        
        var eachUsername = String()
        
        if searchController.isActive && searchController.searchBar.text != nil {
            eachUsername = filteredUsernames[indexPath.row]
        } else {
            eachUsername = usernames[indexPath.row]
        }
        
        cell.selectionStyle = .none
        
        cell.userName?.text = eachUsername
    
        let userID = allUsers[eachUsername]! as String
        
        
        database.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let data = snapshot.value as? [String:Any]
            let user = User(id: "", username: "", email: "", profilePic: "", scoreSingle: "", scoreChallenge: "", scoreMultiplayer: "")
            let userSelected = user.deserialize(data!)

            DispatchQueue.main.async {
                
                cell.retrieveUserInfo(url: userSelected.profilePic, image: cell.userPic!, label: cell.userName, name: userSelected.username)
                
            }    
        })
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if searchController.isActive && searchController.searchBar.text != nil {
            guard let filteredUserAtSelectedRow = allUsers[filteredUsernames[indexPath.row]] else { return }
            selectedUserID = filteredUserAtSelectedRow
        } else {
            let usernameAtSelectedRow = usernames[indexPath.row]
            guard let userIDAtSelectedRow = allUsers[usernameAtSelectedRow] else { return }
            selectedUserID = userIDAtSelectedRow
        }

        if selectedUserID == store.user.id || selectedUserID == store.user2.id || selectedUserID == store.user3.id || selectedUserID == store.user4.id {
        
        } else {
         
            retrieveUsers(id: selectedUserID)
        }
        
    }
    
    func retrieveUsers(id: String) {
        
        database.child("users").child(id).observe( .value, with: { (snapshot) in
            
//            if snapshot.exists() == false {
//                
//            } else {
            
                if self.store.inviteSelected == 2 {
                    self.store.user2 = User(snapshot: snapshot)
                    print(self.store.user2)
                    self.navigationController?.popViewController(animated: true)
                }
                
                if self.store.inviteSelected == 3 {
                    self.store.user3 = User(snapshot: snapshot)
                    self.navigationController?.popViewController(animated: true)
                }
                
                if self.store.inviteSelected == 4 {
                    self.store.user4 = User(snapshot: snapshot)
                    self.navigationController?.popViewController(animated: true) 

//                }
            }
        })
    }
}

extension SearchTableViewController: UISearchResultsUpdating {
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userPic: UIImageView?
    @IBOutlet weak var userName: UILabel!
    
    func retrieveUserInfo(url: String, image: UIImageView, label: UILabel, name: String) {
        
        let profileImgUrl = URL(string: url)
        
        image.contentMode = .scaleAspectFill
        image.setRounded()
        image.clipsToBounds = true
        image.sd_setImage(with: profileImgUrl)
        
        label.text = name
    }
    
}

