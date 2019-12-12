//
//  WelcomeScreenViewController.swift
//  SocialMedia
//
//  Created by Danijela Vrzan on 2019-12-12.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var signInButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.updateLabelText()
            self.signInButton.isHidden = false
        }
        
    }
    
    private func updateLabelText() {
        welcomeLabel.text = "Grab a coffee ☕️ and enjoy latest news from your friends!"
    }
    
    

}
