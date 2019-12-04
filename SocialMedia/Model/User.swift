//
//  User.swift
//  SocialMedia
//
//  Created by Danijela Vrzan on 2019-12-03.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit

struct User: Decodable {
    
    var id: Int
    var avatar: Avatar
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
    
}

struct Address: Decodable {
    
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: Geo
    
}

struct Avatar: Decodable {
    
    var large: String
    var medium: String
    var thumbnail: String
    
}

struct Geo: Decodable {
    
    var lat: String
    var long: String
    
}

struct Company : Decodable {
    
    var name: String
    var catchPhrase: String
    var bs: String
    
}
