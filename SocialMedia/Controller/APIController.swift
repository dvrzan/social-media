//
//  APIController.swift
//  SocialMedia
//
//  Created by Danijela Vrzan on 2019-12-03.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit

class APIController {
    
    static let shared = APIController()
    static let domain = "https://jsonplaceholder.typicode.com/"
    
    let usersEndpoint = "https://api.myjson.com/bins/mnlx0"
    let postsEndpoint = domain + "posts"
    let albumsEndpoint = domain + "albums"
    let photosEndpoint = domain + "photos"

}

