//
//  UserModel.swift
//  SocialMedia
//
//  Created by Danijela Vrzan on 2019-12-03.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import Foundation
import MapKit

struct User: Decodable {
    let id: Int
    let avatar: Avatar
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
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

class Geo: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
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

//extension User {
    //        static func users() -> [User] {
    //            guard
    //                let url = URL(string: APIController.shared.usersEndpoint),
    //                let data = try? Data(contentsOf: url)
    //                else {
    //                    return []
    //            }
    //            do {
    //                let decoder = JSONDecoder()
    //                return try decoder.decode([User].self, from: data)
    //            } catch {
    //                return []
    //            }
    //        }
    
//    static func getUsers(url: URL) {
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            //Ensure there is no error for this HTTP response
//            guard error == nil else {
//                print("Error, \(error!)")
//                return
//            }
//            //Ensure there is data returned from this HTTP response
//            guard let data = data else {
//                print("No data")
//                return
//            }
//            do {
//                let decoder = JSONDecoder()
//                let data = try decoder.decode([User].self, from: data)
//                HomeTableViewController.shared.users = data
//
//                DispatchQueue.main.async {
//                    HomeTableViewController.shared.tableView.reloadData()
//                }
//
//            } catch {
//                print(error)
//            }
//        }
//        //Execute the HTTP request
//        task.resume()
//    }
    
//}
