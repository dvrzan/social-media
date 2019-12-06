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
    var albums: [Album] = []
    var photos: [Photo] = []
    
    @IBOutlet var postTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        users = User.users()
        posts = Post.posts()
        
        postTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "postCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
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
    
}
