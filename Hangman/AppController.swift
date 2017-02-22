//
//  AppController.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/17/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import Foundation
import UIKit

extension Notification.Name {
    
    static let openWelcomeVC = Notification.Name("open-welcome-view-controller")
    static let openLoginVC = Notification.Name("open-login-view-controller")
    static let openRegisterVC = Notification.Name("open-register-view-controller")
    static let openMainVC = Notification.Name("open-main-view-controller")
    static let openGameVC = Notification.Name("open-game-view-controller")
    static let openInfoGameVC = Notification.Name("open-infoGame-view-controller")
}

enum StoryboardID: String {
    
    case welcomeViewController = "welcome-view-controller"
    case loginViewController = "login-view-controller"
    case registerViewController = "register-view-controller"
    case mainViewController = "main-view-controller"
    case gameViewController = "game-game-controller"
    case infoGameViewController = "game-infoGame-controller"
}

class AppController: UIViewController {
    
    let containerView = UIView()
    
    var activeVC = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        addNotificationObservers()
        loadInitialViewController()
    }
}


// MARK: - Notification Observers
extension AppController {
    
    func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(withNotification:)), name: .openLoginVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(withNotification:)), name: .openMainVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(withNotification:)), name: .openWelcomeVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(withNotification:)), name: .openRegisterVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(withNotification:)), name: .openGameVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(withNotification:)), name: .openInfoGameVC, object: nil)
    }
}

// MARK: - Loading View Controllers
extension AppController {
    
    //loads viewControllers based on identifier. need to create id -> pass value to activeVC -> add viewController
    func loadInitialViewController() {
        let id: StoryboardID = .welcomeViewController
        activeVC = loadViewController(withStoryboardID: id)
        add(viewController: activeVC, animated: true)
    }
    
    func loadViewController(withStoryboardID id: StoryboardID) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id.rawValue)
    }
}


// MARK: - Switching View Controllers
extension AppController {
    
    // switch the view of the appcontroller based ont he storyboard id
    func switchViewController(withNotification notification: Notification) {
        
        switch notification.name {
            
        case Notification.Name.openLoginVC:
            switchToViewController(withStoryboardID: .loginViewController)
            
        case Notification.Name.openMainVC:
            switchToViewController(withStoryboardID: .mainViewController)
            
        case Notification.Name.openWelcomeVC:
            switchToViewController(withStoryboardID: .welcomeViewController)
            
        case Notification.Name.openRegisterVC:
            switchToViewController(withStoryboardID: .registerViewController)
            
        case Notification.Name.openGameVC:
            switchToViewController(withStoryboardID: .gameViewController)
            
        case Notification.Name.openInfoGameVC:
            switchToViewController(withStoryboardID: .infoGameViewController)
            
        default:
            fatalError("No notifcation exists.")
            
        }
    }
    
    func switchToViewController(withStoryboardID id: StoryboardID) {
        let existingVC = activeVC
        existingVC.willMove(toParentViewController: nil)
        
        activeVC = loadViewController(withStoryboardID: id)
        addChildViewController(activeVC)
        add(viewController: activeVC)
        
        activeVC.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.activeVC.view.alpha = 1.0
            existingVC.view.alpha = 0.0
            
        }, completion: { _ in
            
            
            existingVC.view.removeFromSuperview()
            existingVC.removeFromParentViewController()
            self.activeVC.didMove(toParentViewController: self)
            
        })
    }
    
}


// MARK: - Adding View Controllers
extension AppController {
    // Have to create parent-child relationship to addd the subview
    func add(viewController: UIViewController, animated: Bool = false) {
        addChildViewController(viewController)
        
        containerView.addSubview(viewController.view)
        containerView.alpha = 0.0
        
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParentViewController: self)
        
        guard animated else { containerView.alpha = 1.0; return }
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.containerView.alpha = 1.0
        })
        
    }
}

