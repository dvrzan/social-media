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
    var userData = "https://api.myjson.com/bins/mnlx0"
    var api = "https://engineering.league.com/challenge/api/"
    
    @IBOutlet var postTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "postCell")

        getUserData()
        
    }
    
    func getUserData(){
        APIController.shared.fetchUserToken(userName: "", password: "", completion: { (result, error) in
            //Check for any errors
            guard error == nil else {
                print("error calling GET on /login")
                print(error!)
                return
            }
            //Make sure we got data
            guard let result = result else {
                print("Error: did not receive data")
                return
            }
            do {
                let decoder = JSONDecoder()
                if let url = URL(string: APIController.shared.loginAPI) {
                    if let json = try? Data(contentsOf: url) {
                        let result = try decoder.decode(User.self, from: json)
                        print(result.apiKey)
                        return
                    }
                }
            } catch let err {
                print("Error, ", err)
            }
        })
    }
    
    func parseJson(api: String) {
        APIController.shared.request(url: URL(string: api)!, completion: { (result, error) in
            print(result as Any)
        })
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

}
