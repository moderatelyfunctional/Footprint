//
//  MapsViewController.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

class MapsViewController: UIViewController {
    
    let directionsJson = ""
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 33.8162219, longitude: -117.9224731, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: 100, height: 100), camera: camera)
        self.view = mapView
        
        // Request for Directions
        let google_url = GoogleMapsAPI.fetchDirectionURL(
            key: "AIzaSyDVuFQ5aAu0kEucO1FM09CaC7eUvLkbxvg",
            origin: "Disneyland",
            destination: "Universal Studios Hollywood")
        
        AF.request(google_url, method: .post, encoding: JSONEncoding.default).responseJSON {
            response in
            print(response.request)
            
            debugPrint(response)

            let directions = try? JSONDecoder().decode(Directions.self, from: response.data!)
            
            debugPrint(directions)
            
            // Creates a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: (directions?.routes[0].legs[0].start_location.lat)!, longitude: (directions?.routes[0].legs[0].start_location.lng)!)
            marker.title = directions?.routes[0].legs[0].start_address
//            marker.snippet = "Australia"
            marker.map = mapView
            
            var bounds = GMSCoordinateBounds()
            let path: GMSPath = GMSPath(fromEncodedPath: (directions?.routes[0].overview_polyline.points)!)!
            let routePolyline = GMSPolyline(path: path)
            routePolyline.strokeWidth = 10
            routePolyline.strokeColor = UIColor.red
            
            routePolyline.map = mapView
            
            for index in 1...path.count() {
                bounds = bounds.includingCoordinate(path.coordinate(at: index))
            }
        }

        let topView = UIView(frame: CGRect(x: 0, y: 1, width: 100, height: 100))
        topView.backgroundColor = UIColor.red
        self.view.addSubview(topView)
    }

}
