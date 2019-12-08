//
//  HomeTableViewController.swift
//  SocialMedia
//
//  Created by Danijela Vrzan on 2019-12-03.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var users: [User] = []
    var posts: [Post] = []
    
    let usersUrl = URL(string: "https://api.myjson.com/bins/mnlx0")
    let postsUrl = URL(string: "https://jsonplaceholder.typicode.com/posts")
    
    @IBOutlet var postTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "postCell")
        
        fetchUsers(url: usersUrl!)
        fetchPosts(url: postsUrl!)
        
    }
    
    // MARK: - Request and parse /users
    func fetchUsers(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            //Ensure there is no error for this HTTP response
            guard error == nil else {
                print("Error, \(error!)")
                return
            }
            //Ensure there is data returned from this HTTP response
            guard let data = data else {
                print("No data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode([User].self, from: data)
                self.users = data
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print(error)
            }
        }
        //Execute the HTTP request
        task.resume()
    }
    
    // MARK: - Request and parse /posts
    func fetchPosts(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            //Ensure there is no error for this HTTP response
            guard error == nil else {
                print("Error, \(error!)")
                return
            }
            //Ensure there is data returned from this HTTP response
            guard let data = data else {
                print("No data")
                return
            }
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode([Post].self, from: data)
                self.posts = data
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print(error)
            }
        }
        //Execute the HTTP request
        task.resume()
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "ShowProfileScreen",
            let indexPath = tableView.indexPathForSelectedRow,
            let profileViewController = segue.destination as? ProfileViewController
            else {
                return
        }
        
        let post = posts[indexPath.row]
        for user in users {
            if post.userId == user.id {
                profileViewController.user = user
            }
        }
        
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        
        let post = self.posts[indexPath.row]
        for user in users {
            if post.userId == user.id {
                cell.titleLabel.text = post.title
                cell.descriptionLabel.text = post.body
                cell.nameLabel.text = user.name
                let data = try? Data(contentsOf: user.avatar.thumbnail)
                cell.avatarImageView.image = UIImage(data: data!)
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      defer {
        tableView.deselectRow(at: indexPath, animated: true)
      }
      
      let post = posts[indexPath.row]
      performSegue(withIdentifier: "ShowProfileScreen", sender: post)
    }
    
}
