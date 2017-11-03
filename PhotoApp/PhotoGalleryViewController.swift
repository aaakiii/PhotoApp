import UIKit
import Alamofire
import SwiftyJSON

class PhotoGalleryViewController: UIViewController,
UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    var searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    var photos = [Photo]()
    var selectedPhoto: Photo?
    var searchResult = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
//        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = false
//        searchController.searchBar.sizeToFit()
        searchBar.enablesReturnKeyAutomatically = false
        
        getImages(tag: searchBar.text!)
        
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
    
//    func updateSearchResults(for searchController: UISearchController) {
//        //検索文字列を含むデータを検索結果配列に格納する。
//        getImages(tag: searchBar.text!)
//
//        //テーブルビューを再読み込みする。
//        collectionView.reloadData()
//    }
//

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        getImages(tag: searchText)

    }


    
    
    func getImages(tag: String){
        Flickr.getImage(tag: searchBar.text!){ (photos) in
            var imageData = [Photo]()
            imageData = Flickr.photos
            self.photos = imageData
            self.collectionView.reloadData()
        }
        
    }
    
    
}


