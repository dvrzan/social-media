//
//  PostModel.swift
//  SocialMedia
//
//  Created by Danijela Vrzan on 2019-12-06.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import Foundation

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

extension Post {
    static func posts() -> [Post] {
        guard
            let url = URL(string: APIController.shared.postsEndpoint),
            let data = try? Data(contentsOf: url)
            else {
                return []
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Post].self, from: data)
        } catch {
            return []
        }
    }
    
}
