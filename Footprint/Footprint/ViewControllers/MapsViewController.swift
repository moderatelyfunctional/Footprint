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

class MapsViewController: UIViewController, TripChangeProtocol, TripConfirmProtocol {

    let tripScrollView = TripScrollView()
    let tripConfirm = TripConfirm()
    let userMarker = GMSMarker()
    
    let whereToBtn = AutoButton(text: "Where To?", titleColor: UIColor.black, backgroundColor: UIColor.white)

    var directions: Directions!
    var routePolyline: GMSPolyline!
    var greenPolyline: GMSPolyline!
    
    var timer = Timer()
    var autoCounter = 0
    var stepNumber = -1
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.tripScrollView.trip_confirm_delegate = self
        self.tripScrollView.firstView.trip_delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateMap(place: GMSPlace) {
        let camera = GMSCameraPosition.camera(withLatitude: UserInfo.currPosition.0, longitude: UserInfo.currPosition.1, zoom: 6.0)
        // let camera = GMSCameraPosition.camera(withLatitude: selectedPlace.coordinate.latitude, longitude: selectedPlace.coordinate.longitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: 100, height: 100), camera: camera)
        self.view = mapView
        
        // Request for Directions
        let google_url = GoogleMapsAPI.fetchDirectionURL(
            key: "AIzaSyDVuFQ5aAu0kEucO1FM09CaC7eUvLkbxvg",
            origin: "\(UserInfo.currPosition.0),\(UserInfo.currPosition.1)",
            destination: place.name!)
        
        AF.request(google_url, method: .post, encoding: JSONEncoding.default).responseJSON {
            response in
            self.directions = try? JSONDecoder().decode(Directions.self, from: response.data!)
            
            // Creates a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: (self.directions?.routes[0].legs[0].end_location.lat)!, longitude: (self.directions?.routes[0].legs[0].end_location.lng)!)
            marker.title = self.directions?.routes[0].legs[0].end_address
            //            marker.snippet = "Australia"
            marker.map = mapView
            
//             = GMSMarker()
            self.userMarker.position = CLLocationCoordinate2D(latitude: UserInfo.currPosition.0, longitude: UserInfo.currPosition.1)
            self.userMarker.title = "Current Position"
            //            marker.snippet = "Australia"
            self.userMarker.map = mapView
            self.view = mapView
            
            var bounds = GMSCoordinateBounds()
            let path: GMSPath = GMSPath(fromEncodedPath: (self.directions?.routes[0].overview_polyline.points)!)!
            
            if (self.routePolyline != nil) {
                self.routePolyline.map = nil
            }
            self.routePolyline = GMSPolyline(path: path)
            self.routePolyline.strokeWidth = 10
            self.routePolyline.strokeColor = UIColor.red
            
            self.routePolyline.map = mapView
            
            for index in 1...path.count() {
                bounds = bounds.includingCoordinate(path.coordinate(at: index))
            }
            
            let northeast = self.directions.routes[0].bounds.northeast
            let southwest = self.directions.routes[0].bounds.southwest
            
            bounds = bounds.includingCoordinate(CLLocationCoordinate2D(latitude: northeast.lat + 0.388 * (northeast.lat - southwest.lat), longitude: northeast.lng))
            bounds = bounds.includingCoordinate(CLLocationCoordinate2D(latitude: southwest.lat - 0.805 * (northeast.lat - southwest.lat), longitude: southwest.lng))
            mapView.animate(with: GMSCameraUpdate.fit(bounds))
            self.updateGreenPath()
        }
        self.makeButton()
        self.makeTripForm()

    }
    
    override func loadView() {
        super.loadView()
        let camera = GMSCameraPosition.camera(withLatitude: UserInfo.currPosition.0, longitude: UserInfo.currPosition.1, zoom: 6.0)
        // let camera = GMSCameraPosition.camera(withLatitude: selectedPlace.coordinate.latitude, longitude: selectedPlace.coordinate.longitude, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: 100, height: 100), camera: camera)
        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
        self.userMarker.position = CLLocationCoordinate2D(latitude: UserInfo.currPosition.0, longitude: UserInfo.currPosition.1)
        self.userMarker.title = "Current Position"
        //            marker.snippet = "Australia"
        self.userMarker.map = mapView
        self.view = mapView
        self.makeButton()
    }
    
    // Add a button to the view.
    func makeButton() {
        whereToBtn.addTarget(self, action: #selector(autocompleteClicked), for: .touchUpInside)
        self.view.addSubview(whereToBtn)
        
        self.view.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: whereToBtn, sides: [.left, .right], padding: 30))
        self.view.addConstraint(FLayoutConstraint.paddingPositionConstraint(view: whereToBtn, side: .top, padding: 70))
        self.view.addConstraint(FLayoutConstraint.constantConstraint(view: whereToBtn, attribute: .height, value: 40))
    }
    
    func makeTripForm() {
        self.view.addSubview(self.tripScrollView)
        self.view.addSubview(self.tripConfirm)
        
        self.tripConfirm.confirm_button.addTarget(self, action: #selector(MapsViewController.startTrip), for: .touchUpInside)
        
        self.view.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.tripScrollView, sides: [.left, .right], padding: 0))
        self.view.addConstraint(FLayoutConstraint.verticalSpacingConstraint(upperView: self.tripScrollView, lowerView: self.tripConfirm, spacing: 0))
        self.view.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.tripConfirm, sides: [.left, .bottom, .right], padding: 0))
    }
    
    func incrementGreenPath() {
        updateGreenPath()
    }
    
    func decrementGreenPath() {
        updateGreenPath()
    }
    
    func confirmTrip() {
        self.tripConfirm.changeButtonState(enable: true)
    }
    
    func updateGreenPath() {
        let greenMiles = Double(self.tripScrollView.firstView.curr_miles) / 10.0
        let greenMeters = greenMiles * 1609.34
        // var totalMeters = directions.routes[0].legs[0].distance.value
        let greenPath = GMSMutablePath(fromEncodedPath: (self.directions?.routes[0].overview_polyline.points)!)!
        
        while (greenPath.length(of: GMSLengthKind.rhumb) > greenMeters) {
            greenPath.removeCoordinate(at: 0)
        }
        
        if (greenPolyline != nil) {
            greenPolyline.map = nil
        }
        greenPolyline = GMSPolyline(path: greenPath)
        greenPolyline.strokeWidth = 10
        greenPolyline.strokeColor = UIColor.green
        
        greenPolyline.map = (self.view as! GMSMapView)
        
    }
    
    @objc func startTrip() {
        
//        let greenMiles = 1.0
//        let n_persons = 4
//        let car_type = "Kia"
//
//        let steps = directions.routes[0].legs[0].steps
//        for step in steps {
//            if let unwrapped = step.html_instructions.removingPercentEncoding?.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "") {
//                print(unwrapped)
//            }
//            print(step.html_instructions.removingPercentEncoding)
//        }
        
        if (UserInfo.userID == 7) {
            scheduledTimerWithTimeInterval()
        }
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        autoCounter = 0
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(MapsViewController.autoWalk), userInfo: nil, repeats: true)
    }
    
    @objc func autoWalk() {
        // routePolyline.path
        userMarker.position = (routePolyline.path?.coordinate(at: UInt(self.autoCounter)))!
        self.autoCounter += 1
        
        // instruction check
        for i in 0..<self.directions.routes[0].legs[0].steps.count {
            if (self.stepNumber != i && GMSGeometryIsLocationOnPath(userMarker.position, GMSPath(fromEncodedPath: self.directions.routes[0].legs[0].steps[i].polyline.points)!, true)) {
                stepNumber = i
                if let decoded = self.directions.routes[0].legs[0].steps[i].html_instructions.removingPercentEncoding {
                        processString(html_string: decoded)
                }
            }
        }
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
        self.whereToBtn.setTitle(place.name, for: .normal)
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

