import UIKit
import MapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let map = MKMapView(frame: view.bounds)
        map.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        view.addSubview(map)

        var annotations = NSMutableArray()

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let pointData = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("3000", ofType: "geojson")!)
            let points = NSJSONSerialization.JSONObjectWithData(pointData!,
                options: nil,
                error: nil) as NSDictionary
            for point in points["features"] as NSArray {
                let coordinate = (point["geometry"] as NSDictionary)["coordinates"] as NSArray
                let lon = coordinate[0] as CLLocationDegrees
                let lat = coordinate[1] as CLLocationDegrees
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                annotations.addObject(a)
            }
            dispatch_async(dispatch_get_main_queue()) {
                map.addAnnotations(annotations)
                map.showAnnotations(map.annotations, animated: false)
            }
        }

    }

}
