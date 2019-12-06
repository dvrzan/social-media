//
//  PhotoModel.swift
//  SocialMedia
//
//  Created by Danijela Vrzan on 2019-12-06.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
}

extension Photo {
    static func photos() -> [Photo] {
        guard
            let url = URL(string: APIController.shared.photosEndpoint),
            let data = try? Data(contentsOf: url)
            else {
                return []
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Photo].self, from: data)
        } catch {
            return []
        }
    }
    
}
