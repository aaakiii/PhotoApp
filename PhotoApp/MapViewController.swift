import UIKit
import MapKit

class MapViewController: UIViewController,  MKMapViewDelegate {
    

    @IBOutlet var mapView: MKMapView!
      var selectedPhoto: Photo!

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let latitude = selectedPhoto.latitude
        let longitude = selectedPhoto.longitude
        
        
        let coordinate = CLLocationCoordinate2DMake(longitude, longitude)
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegionMake(coordinate, span)
        mapView.setRegion(region, animated:true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        self.mapView.addAnnotation(annotation)
        // Do any additional setup after loading the view.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.animatesDrop = true
        } else {
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    
}
