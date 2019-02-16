//
//  MapsViewController.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit
import GoogleMaps

class MapsViewController: UIViewController {
    
    let directionsJson = ""
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 33.8162219, longitude: -117.9224731, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: 100, height: 100), camera: camera)
        self.view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 33.8162219, longitude: -117.9224731)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        // polylines
        let encodedPoints = ["kvkmElvvnU\\J", "mukmExvvnUH@H@JDJHNJJJPTN\\Lb@B`@?h@@v@DdYZ?R?" ]
        var bounds = GMSCoordinateBounds()

        for encoding in encodedPoints {
            let path: GMSPath = GMSPath(fromEncodedPath: encoding)!
            let routePolyline = GMSPolyline(path: path)
            routePolyline.strokeWidth = 50
            routePolyline.strokeColor = UIColor.red
            
            routePolyline.map = mapView
            
            
            
            for index in 1...path.count() {
                bounds = bounds.includingCoordinate(path.coordinate(at: index))
            }
        }
        mapView.animate(with: GMSCameraUpdate.fit(bounds))
        
        let topView = UIView(frame: CGRect(x: 0, y: 1, width: 100, height: 100))
        topView.backgroundColor = UIColor.red
        self.view.addSubview(topView)
    }
    
    override func viewDidLoad() {
        // let mapView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        // view.backgroundColor = UIColor.red
        
        
        
        // self.view.addSubview(<#T##view: UIView##UIView#>)
        
        self.view.backgroundColor = UIColor.green
        
//        self.view.addSubview(mapView)
    }
    
}
