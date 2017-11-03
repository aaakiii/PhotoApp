import UIKit
import Alamofire
import SwiftyJSON

class PhotoGalleryViewController: UIViewController,
UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var collectionView: UICollectionView!
    
    var photos = [Photo]()
    var selectedPhoto: Photo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
//        let nib = UINib(nibName:"PhotoCollectionViewCell", bundle:nil)
//        collectionView.register(nib, forCellWithReuseIdentifier:"Cell")
        getImages()
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCollectionViewCell
        photoCell.setImage(photo:photos[indexPath.row])
        return photoCell
    }
    func collectionVIew(_ collectionView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Search and set recipeData from [indexPath.row]
        selectedPhoto = Photo(title: photos[indexPath.row].title, imageByUrl:
            photos[indexPath.row].imageByUrl, takenDate: photos[indexPath.row].takenDate, latitude: photos[indexPath.row].latitude, longitude: photos[indexPath.row].longitude)
        selectedPhoto = photos[indexPath.row]
        if selectedPhoto != nil {
            // Go to detail view and pass recipe data
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "Map") as! MapViewController
            nextView.selectedPhoto = selectedPhoto
            self.navigationController?.pushViewController(nextView, animated: true)
            
        }
    }
    
    
    
//    // When cell is selected
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        selectedPhoto = Photo(title: photos[indexPath.row].title, imageByUrl:
//            photos[indexPath.row].imageByUrl, takenDate: photos[indexPath.row].takenDate, latitude: photos[indexPath.row].latitude, longitude: photos[indexPath.row].longitude)
//
//        
//        selectedPhoto = photos[indexPath.row]
//    }
    
    
    func getImages(){
        Flickr.getImage{ (photos) in
            var imageData = [Photo]()
            imageData = Flickr.photos
            self.photos = imageData
            self.collectionView.reloadData()
        }
        
    }
    
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //        collectionView.delegate = self
    //        collectionView.dataSource = self
    //        self.title = "Photo Library"
    //        searchBar.delegate = self
    //        searchBar.enablesReturnKeyAutomatically = false
    //        searchBar.text = ""
    //        searchBar.resignFirstResponder()
    //
    //        getImages()
    //
    //    }
    //    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //        return photos.count
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
    //        photoCell.setImage(photo:photos[indexPath.row])
    //        return photoCell
    //    }
    //
    //
    //    // When cell is selected
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        selectedPhoto = Photo(title: photos[indexPath.row].title, imageByUrl:
    //            photos[indexPath.row].imageByUrl, takenDate: photos[indexPath.row].takenDate, latitude: photos[indexPath.row].latitude, longitude: photos[indexPath.row].longitude)
    //
    //        selectedPhoto = photos[indexPath.row]
    //    }
    //
    //
    //    func getImages(){
    //        Flickr.getImage{ (photos) in
    //            var imageData = [Photo]()
    //            imageData = Flickr.photos
    //            self.photos = imageData
    //            self.collectionView.reloadData()
    //        }
    //
    //    }
    //
    
    
    
}


