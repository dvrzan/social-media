//
//  HomeTableViewController.swift
//  SocialMedia
//
//  Created by Danijela Vrzan on 2019-12-03.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var users = [User]()
    var posts = [Post]()
    var albums = [Album]()
    var photos = [Photo]()
    
    @IBOutlet var postTableView: UITableView!
    
    let apiController = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "postCell")
        
        requestUsers()

    }

    
    
    //MARK: - Parse /users
    
    func requestUsers() {
        if let url = URL(string: apiController.usersEndpoint) {
            if let json = try? Data(contentsOf: url) {
                parseUserJSON(data: json)
            }
        }
    }
    
    func parseUserJSON(data: Data) {
        let decoder = JSONDecoder()
        if let decodedData = try? decoder.decode([User].self, from: data) {
            users = decodedData
        }
    }
    
    //MARK: - Error
    func showError() {
        let alert = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.users.count
    }
    

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
     
        let user = self.users[indexPath.row]
        cell.nameLabel.text = user.name
        let data = try? Data(contentsOf: user.avatar.thumbnail)
        cell.avatarImageView.image = UIImage(data: data!)
     
        return cell
     }
    
}
