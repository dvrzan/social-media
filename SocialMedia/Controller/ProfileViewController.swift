//
//  ProfileViewController.swift
//  SocialMedia
//
//  Created by Danijela Vrzan on 2019-12-06.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var streetLabel: UILabel!
    @IBOutlet var suiteLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var zipcodeLabel: UILabel!
    @IBOutlet var websiteLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var catchPhraseLabel: UILabel!
    @IBOutlet var bsLabel: UILabel!
    
    @IBOutlet var albumTableView: UITableView!
    
    var selectedPost: Post? {
        didSet {
            DispatchQueue.main.async {
                self.configureView()
            }
        }
    }
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
    }
    
    func configureView() {
        if let user = user,
            let avatarImageView = avatarImageView,
            let nameLabel = nameLabel,
            let emailLabel = emailLabel,
            let phoneLabel = phoneLabel,
            let streetLabel = streetLabel,
            let suiteLabel = suiteLabel,
            let cityLabel = cityLabel,
            let zipcodeLabel = zipcodeLabel,
            let websiteLabel = websiteLabel,
            let companyLabel = companyLabel,
            let catchPhraseLabel = catchPhraseLabel,
            let bsLabel = bsLabel {
            let data = try? Data(contentsOf: user.avatar.medium)
            avatarImageView.image = UIImage(data: data!)
            nameLabel.text = user.name
            emailLabel.text = user.email
            phoneLabel.text = user.phone
            streetLabel.text = user.address.street
            suiteLabel.text = user.address.suite
            cityLabel.text = user.address.city
            zipcodeLabel.text = user.address.zipcode
            websiteLabel.text = user.website
            companyLabel.text = user.company.name
            catchPhraseLabel.text = user.company.catchPhrase
            bsLabel.text = user.company.bs
        }
    }
    
    
}
