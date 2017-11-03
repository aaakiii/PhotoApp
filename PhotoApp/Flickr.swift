import UIKit
import Alamofire
import SwiftyJSON


class Flickr{
    
    
    static var photos = [Photo]()
    
    static func getImage(completion: @escaping(_ photos: [Photo]) -> Void){
        
        let baseUrl = "https://api.flickr.com/services/rest/"
        let apiKey = "effab55429eaf872edf9f365ca237918"
        let serchMethod = "flickr.photos.search"
        let formatType = "json"
        let jsonCallback = 1
        let privercyFilter = 1
        let hasGeo = "1"
        let extras = "url_s,date_taken"
        let tag = ""
        let query = ["method": serchMethod, "api_key": apiKey, "tags":tag, "privacy_filter":privercyFilter, "format":formatType, "nojsoncallback": jsonCallback, "has_geo": hasGeo, "extras":extras] as [String : Any]
        
        
        // Call JSON Data
        Alamofire.request(baseUrl, parameters: query).responseJSON{ response in
            guard let object = response.result.value else {
                return
            }
            let body = JSON(object)
            for(_, photos): (String, JSON) in body["photos"]["photo"]{
                // Add each data to Photo array
                Flickr.photos.append(Photo(title: photos["title"].stringValue, imageByUrl: photos["url_s"].stringValue, takenDate: photos["date_taken"].stringValue, latitude: photos["latitude"].stringValue, longitude: photos["longitude"].stringValue))
                
            }
            print(Flickr.photos)
            completion(Flickr.photos)
        }
    }
}
