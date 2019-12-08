//
//  ProfileViewController.swift
//  SocialMedia
//
//  Created by Danijela Vrzan on 2019-12-06.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit
import MapKit

class ProfileViewController: UIViewController, UITableViewDataSource {
    
    var albums: [Album] = []
    var photos: [Photo] = []
    
    let albumsUrl = URL(string: "https://jsonplaceholder.typicode.com/albums")
    let photosUrl = URL(string: "https://jsonplaceholder.typicode.com/photos")
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var streetLabel: UILabel!
    @IBOutlet var suiteLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var zipcodeLabel: UILabel!
    @IBOutlet var websiteLabel: UILabel!
    @IBOutlet var companyLabel: UILabel!
    @IBOutlet var catchPhraseLabel: UILabel!
    @IBOutlet var bsLabel: UILabel!
    
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var albumTableView: UITableView!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumTableView.dataSource = self
        
        let latitude = CLLocationDegrees(Double((user?.address.geo.lat)!)!)
        let longitude = CLLocationDegrees(Double((user?.address.geo.lng)!)!)
        
        let location = Geo(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        
        configureUserInfo()
        
        mapView.addAnnotation(location)
        mapView.setCenter(CLLocationCoordinate2D(latitude: latitude, longitude: longitude), animated: false)
        
        albumTableView.register(UINib(nibName: "AlbumCell", bundle: nil), forCellReuseIdentifier: "albumCell")
        
        fetchAlbums(url: albumsUrl!)
        fetchPhotos(url: photosUrl!)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = albumTableView.indexPathForSelectedRow {
            albumTableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func configureUserInfo() {
        if let user = user,
            let avatarImageView = avatarImageView,
            let nameLabel = nameLabel,
            let emailLabel = emailLabel,
            let phoneLabel = phoneLabel,
            let streetLabel = streetLabel,
            let suiteLabel = suiteLabel,
            let cityLabel = cityLabel,
            let zipcodeLabel = zipcodeLabel,
            let websiteLabel = websiteLabel,
            let companyLabel = companyLabel,
            let catchPhraseLabel = catchPhraseLabel,
            let bsLabel = bsLabel {
            let data = try? Data(contentsOf: user.avatar.large)
            avatarImageView.image = UIImage(data: data!)
            nameLabel.text = user.name
            emailLabel.text = user.email
            phoneLabel.text = user.phone
            streetLabel.text = user.address.street
            suiteLabel.text = user.address.suite
            cityLabel.text = user.address.city
            zipcodeLabel.text = user.address.zipcode
            websiteLabel.text = user.website
            companyLabel.text = user.company.name
            catchPhraseLabel.text = user.company.catchPhrase
            bsLabel.text = user.company.bs
        }
    }
    
    // MARK: - Request and parse /albums
    func fetchAlbums(url: URL) {
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
                let data = try decoder.decode([Album].self, from: data)
                self.albums = data
                
                DispatchQueue.main.async {
                    self.albumTableView.reloadData()
                }
                
            } catch {
                print(error)
            }
        }
        //Execute the HTTP request
        task.resume()
    }
    
    // MARK: - Request and parse /photos
    func fetchPhotos(url: URL) {
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
                let data = try decoder.decode([Photo].self, from: data)
                self.photos = data
                
                DispatchQueue.main.async {
                    self.albumTableView.reloadData()
                }
                
            } catch {
                print(error)
            }
        }
        //Execute the HTTP request
        task.resume()
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albums.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as! AlbumCell
        
        let album = self.albums[indexPath.row]
        for photo in photos {
            if user?.id == album.userId {
                    if photo.albumId == album.id {
                        cell.albumTitleLabel.text = album.title
                        let data = try? Data(contentsOf: photo.thumbnailUrl)
                        cell.photo1ImageView.image = UIImage(data: data!)
                }
            }
        }
        
        return cell
    }
    
}


