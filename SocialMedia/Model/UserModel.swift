//
//  UserModel.swift
//  SocialMedia
//
//  Created by Danijela Vrzan on 2019-12-03.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import Foundation

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

extension User {
    static func users() -> [User] {
        guard
            let url = URL(string: APIController.shared.usersEndpoint),
            let data = try? Data(contentsOf: url)
            else {
                return []
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([User].self, from: data)
        } catch {
            return []
        }
    }
    
}
