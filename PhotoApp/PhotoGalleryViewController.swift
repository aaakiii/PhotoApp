import UIKit
import Alamofire
import SwiftyJSON

class PhotoGalleryViewController: UIViewController,
UICollectionViewDataSource, UICollectionViewDelegate, UISearchResultsUpdating {
    
    
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
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchBar.enablesReturnKeyAutomatically = false
        searchResult = photos
        getImages(tag: searchBar.text!)
    
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(searchController.searchBar.text != ""){
            return searchResult.count
        } else{
            return photos.count
        }
   
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCollectionViewCell
        if ( searchController.searchBar.text != ""){
            photoCell.setImage(photo:searchResult[indexPath.row])
        } else{
            photoCell.setImage(photo:photos[indexPath.row])
        }
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

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //検索文字列を含むデータを検索結果配列に格納する。
        print(searchBar.text!)
        getImages(tag: searchBar.text!)

        //テーブルビューを再読み込みする。
        collectionView.reloadData()
    }


//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        self.searchBar.endEditing(true)
//        print(searchBar.text!)
//        if(!(searchBar.text?.isEmpty)!){
//            //reload your data source if necessary
//            self.collectionView?.reloadData()
//        }
//
//        getImages(tag: searchBar.text!)
//    }
//
    
    func getImages(tag: String){
        Flickr.getImage(tag: searchBar.text!){ (photos) in
            var imageData = [Photo]()
            imageData = Flickr.photos
            self.photos = imageData
            self.collectionView.reloadData()
        }
        
    }
    
    
    
    
    
}


