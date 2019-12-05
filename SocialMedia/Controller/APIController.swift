//
//  APIController.swift
//  SocialMedia
//
//  Created by Danijela Vrzan on 2019-12-03.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit

class APIController {
    
    let usersEndpoint = "https://jsonplaceholder.typicode.com/users"
    let postsEndpoint = "https://jsonplaceholder.typicode.com/posts"
    let photosEndpoint = "https://jsonplaceholder.typicode.com/photos"
    let albumsEndpoint = "https://jsonplaceholder.typicode.com/albums"
    
    func fetchUsers() {
        performRequest(urlString: usersEndpoint)
    }
    
    func performRequest(urlString: String) {
        //Create URL
        if let url = URL(string: urlString) {
            //Create session URL
            let session = URLSession(configuration: .default)
            //Give session a task
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(data: safeData)
                }
            }
            //Start the task
            task.resume()
        }
    }
    
    func parseJSON(data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([User].self, from: data)
            for data in decodedData {
                print(data.id)
            }
        } catch {
            print(error)
        }
        
    }
    
}

