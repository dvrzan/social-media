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
        
        showSpinner(onView: view)
        
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        
        photoCollectionView.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "photoCell")
        
        if let fetchAlbum = album {
            fetchPhotos(url: URL(string: photosUrl + String(describing: fetchAlbum.id))!)
        }
        
    }
    
    func renderRows() {
        if self.photos.isEmpty {
            return
        }
        self.photoCollectionView.reloadData()
        removeSpinner()
    }
    
    //MARK: Alert
    func showError() {
        let alert = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
    // MARK: Request and parse /photos
    func fetchPhotos(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            //Ensure there is no error for this HTTP response
            guard error == nil else {
                print("Error, \(error!)")
                self.removeSpinner()
                self.showError()
                return
            }
            //Ensure there is data returned from this HTTP response
            guard let data = data else {
                print("No data")
                self.removeSpinner()
                self.showError()
                return
            }
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode([Photo].self, from: data)
                self.photos = data
                
                DispatchQueue.main.async {
                    self.renderRows()
                }
                
            } catch {
                print(error)
                self.removeSpinner()
                self.showError()
            }
        }
        //Execute the HTTP request
        task.resume()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "ShowSinglePhoto",
            let indexPath = photoCollectionView.indexPathsForSelectedItems,
            let photoViewController = segue.destination as? PhotoViewController
            else {
                return
        }
        
        let photo = photos[indexPath[0].row]
        photoViewController.photo = photo
        
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        defer {
            collectionView.deselectItem(at: indexPath, animated: true)
        }
        
        let photo = photos[indexPath.row]
        performSegue(withIdentifier: "ShowSinglePhoto", sender: photo)
    }
    
}
