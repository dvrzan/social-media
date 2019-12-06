//
//  AlbumModel.swift
//  SocialMedia
//
//  Created by Danijela Vrzan on 2019-12-06.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let userId: Int
    let id: Int
    let title: String
}

extension Album {
    static func albums() -> [Album] {
        guard
            let url = URL(string: APIController.shared.albumsEndpoint),
            let data = try? Data(contentsOf: url)
            else {
                return []
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Album].self, from: data)
        } catch {
            return []
        }
    }
    
}
