//
//  UserModel.swift
//  SocialMedia
//
//  Created by Danijela Vrzan on 2019-12-03.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit

struct User: Decodable {
    let id: Int
    let avatar: Avatar
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: URL
    let company: Company
    
    struct Address: Decodable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: Geo
    }
    
    struct Avatar: Decodable {
        let large: URL
        let medium: URL
        let thumbnail: URL
    }
    
    struct Geo: Decodable {
        let lat: String
        let lng: String
    }
    
    struct Company: Decodable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

struct Album: Decodable {
    let userId: Int
    let id: Int
    let title: String
}

struct Photo: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
}

