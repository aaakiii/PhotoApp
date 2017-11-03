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
        searchBar.text = ""
//        searchBar.delegate = self
//        searchBar.enablesReturnKeyAutomatically = false

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
    // when image is selected
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "Map"?:
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                                let photo = photos[selectedIndexPath.row]
                                let destinationVC = segue.destination as! MapViewController
                                destinationVC.selectedPhoto = photo
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }

//
//    func searchBarButtonClicked(_ seachBar: UISearchBar) {
//        searchBar.endEditing(true)
//        if()
//        searchBar.resignFirstResponder()
//
//    }
//

    
    
    func getImages(){
        Flickr.getImage{ (photos) in
            var imageData = [Photo]()
            imageData = Flickr.photos
            self.photos = imageData
            self.collectionView.reloadData()
        }
        
    }
    
    
}


