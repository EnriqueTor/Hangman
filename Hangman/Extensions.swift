//
//  Extensions.swift
//  Hangman
//
//  Created by Enrique Torrendell on 2/16/17.
//  Copyright © 2017 Tor. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

extension UINavigationBar {
    
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        
        let backButton = UIImage(named: "Arrow")
        self.backIndicatorImage = backButton
        self.backIndicatorTransitionMaskImage = backButton
        self.backItem?.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)

//        self.backItem?.leftBarButtonItem?.setBackgroundImage(UIImage(named: "Arrow"), for: .normal, barMetrics: .compact)
    }
}

extension UITabBar {
    
    func transparentNavigationBar() {
        self.backgroundImage = UIImage()
        self.shadowImage = UIImage()
        self.isTranslucent = true
        self.tintColor = UIColor.white
        
    }
}

extension UIImageView {
    
    func addBlurEffect() {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}
