//
//  PhotoCollectionViewController.swift
//  SocialMedia
//
//  Created by Danijela Vrzan on 2019-12-08.
//  Copyright © 2019 Danijela Vrzan. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController {
    
    @IBOutlet var photoCollectionView: UICollectionView!
    
    var photos: [Photo] = []
    
    var album: Album?
    
    let photosUrl = "https://jsonplaceholder.typicode.com/photos?albumId="
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoCollectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
        
        if let fetchAlbum = album {
            fetchPhotos(url: URL(string: photosUrl + String(describing: fetchAlbum.id))!)
        }
        
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
                    self.photoCollectionView.reloadData()
                }
                
            } catch {
                print(error)
            }
        }
        //Execute the HTTP request
        task.resume()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        
        let photo = photos[indexPath.row]
        let data = try? Data(contentsOf: photo.thumbnailUrl)
        cell.photoImageView.image = UIImage(data: data!)
        
        return cell
    }
    
}
