//
//  PhotoViewController.swift
//  SocialMedia
//
//  Created by Danijela Vrzan on 2019-12-08.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet var photoImageView: UIImageView!
    
    var photo: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = try? Data(contentsOf: photo!.url)
        photoImageView.image = UIImage(data: data!)
        
    }
    
}
