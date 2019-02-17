//
//  MapsViewController.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire

class MapsViewController: UIViewController {

    let tripScrollView = TripScrollView()
    let tripConfirm = TripConfirm()

    func updateMap(place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: UserInfo.currPosition.0, longitude: UserInfo.currPosition.1, zoom: 6.0)
        // let camera = GMSCameraPosition.camera(withLatitude: selectedPlace.coordinate.latitude, longitude: selectedPlace.coordinate.longitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: 100, height: 100), camera: camera)
        self.view = mapView
        
        print("\(UserInfo.currPosition.0),\(UserInfo.currPosition.1)")
        // Request for Directions
        let google_url = GoogleMapsAPI.fetchDirectionURL(
            key: "AIzaSyDVuFQ5aAu0kEucO1FM09CaC7eUvLkbxvg",
            origin: "\(UserInfo.currPosition.0),\(UserInfo.currPosition.1)",
            destination: place.name!)
        
        AF.request(google_url, method: .post, encoding: JSONEncoding.default).responseJSON {
            response in
            let directions = try? JSONDecoder().decode(Directions.self, from: response.data!)
            
            // Creates a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: (directions?.routes[0].legs[0].end_location.lat)!, longitude: (directions?.routes[0].legs[0].end_location.lng)!)
            marker.title = directions?.routes[0].legs[0].end_address
            //            marker.snippet = "Australia"
            marker.map = mapView
            
            let marker2 = GMSMarker()
            marker2.position = CLLocationCoordinate2D(latitude: UserInfo.currPosition.0, longitude: UserInfo.currPosition.1)
            marker2.title = "Current Position"
            //            marker.snippet = "Australia"
            marker2.map = mapView
            self.view = mapView
            
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
        self.makeButton()
    }
    
    override func loadView() {
        super.loadView()
        let camera = GMSCameraPosition.camera(withLatitude: UserInfo.currPosition.0, longitude: UserInfo.currPosition.1, zoom: 6.0)
        // let camera = GMSCameraPosition.camera(withLatitude: selectedPlace.coordinate.latitude, longitude: selectedPlace.coordinate.longitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: 100, height: 100), camera: camera)
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: UserInfo.currPosition.0, longitude: UserInfo.currPosition.1)
        marker.title = "Current Position"
        //            marker.snippet = "Australia"
        marker.map = mapView
        self.view = mapView
        self.makeButton()
    }
    
    // Add a button to the view.
    func makeButton() {
        let whereToBtn = AutoButton(text: "Where To?", titleColor: UIColor.black, backgroundColor: UIColor.white)
        whereToBtn.addTarget(self, action: #selector(autocompleteClicked), for: .touchUpInside)
        self.view.addSubview(whereToBtn)
        
        self.view.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: whereToBtn, sides: [.left, .right], padding: 30))
        self.view.addConstraint(FLayoutConstraint.paddingPositionConstraint(view: whereToBtn, side: .top, padding: 70))
        self.view.addConstraint(FLayoutConstraint.constantConstraint(view: whereToBtn, attribute: .height, value: 40))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tripScrollView)
        self.view.addSubview(self.tripConfirm)
        
        self.view.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.tripScrollView, sides: [.left, .right], padding: 0))
        self.view.addConstraint(FLayoutConstraint.verticalSpacingConstraint(upperView: self.tripScrollView, lowerView: self.tripConfirm, spacing: 0))
        self.view.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.tripConfirm, sides: [.left, .bottom, .right], padding: 0))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // Present the Autocomplete view controller when the button is pressed.
    @objc func autocompleteClicked(_ sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue))!
        autocompleteController.placeFields = fields
        
        // Specify a filter.
        //        let filter = GMSAutocompleteFilter()
        //        filter.type = .address
        //        autocompleteController.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
}

extension MapsViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        dismiss(animated: true, completion: nil)
        updateMap(place: place)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

