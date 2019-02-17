//
//  UserViewController.swift
//  Footprint
//
//  Created by Jing Lin on 2/17/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit
import Alamofire

class UserViewController: UIViewController {
    
    var latest_emission:Double!
    var cumulative_emission:Double!
    var elements:NSArray!
    
    let titleLabel = AutoLabel(text: "Trips Completed", textColor: LoginVC.primaryGreen)
    let latestLabel = AutoLabel(text: "Latest Carbon", textColor: LoginVC.primaryGreen)
    let cumulaLabel = AutoLabel(text: "Cumulative Carbon", textColor: LoginVC.primaryGreen)
    let quitImage = UIImageView(image: UIImage(named: "x"))
    
    let userTrips = UserTrips()

    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = UIColor.white
        
        var params:Parameters = [:]
//        params["user_id"] = UserInfo.userID
        params["user_id"] = 7
    
        AF.request(FPServerAPI.statsURL, method: .post, parameters: params).responseJSON {
            responseData in
            if (responseData.response?.statusCode == 200) {
                let data = responseData.result.value
                let JSON = data as! NSDictionary
                self.latest_emission = JSON.object(forKey: "latest") as! Double
                self.cumulative_emission = JSON.object(forKey: "cumulative") as! Double
                self.elements = JSON.object(forKey: "city_trips_recent_json") as! NSArray

                self.latestLabel.text = "Latest Trip \((self.latest_emission!).rounded(toPlaces: 4))g Carbon"
                self.cumulaLabel.text = "Cumulative \((self.cumulative_emission!).rounded(toPlaces: 4))g Carbon"
                self.userTrips.trips = self.elements
                self.userTrips.reloadData()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.latestLabel.font = UIFont(name: "Avenir", size: 18)
        self.cumulaLabel.font = UIFont(name: "Avenir", size: 18)
        
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(UserViewController.dismissViewController))
        
        self.quitImage.translatesAutoresizingMaskIntoConstraints = false
        self.quitImage.isUserInteractionEnabled = true
        self.quitImage.addGestureRecognizer(gestureRecognizer)
        
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.latestLabel)
        self.view.addSubview(self.cumulaLabel)
        self.view.addSubview(self.userTrips)
        self.view.addSubview(self.quitImage)
        
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.titleLabel, sides: [.top, .left], padding: 45))
        self.view.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.latestLabel, sides: [.left, .right], padding: 45))
        self.view.addConstraint(FLayoutConstraint.verticalSpacingConstraint(upperView: self.titleLabel, lowerView: self.latestLabel, spacing: 20))
        
        self.view.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.cumulaLabel, sides: [.left, .right], padding: 45))
        self.view.addConstraint(FLayoutConstraint.verticalSpacingConstraint(upperView: self.latestLabel, lowerView: self.cumulaLabel, spacing: 10))
        
        self.view.addConstraint(FLayoutConstraint.verticalSpacingConstraint(upperView: self.cumulaLabel, lowerView: self.userTrips, spacing: 30))
        self.view.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.userTrips, sides: [.left, .right], padding: 30))
        self.view.addConstraint(FLayoutConstraint.paddingPositionConstraint(view: self.userTrips, side: .bottom, padding: 20))
        
        self.view.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.quitImage, sides: [.top, .right], padding: 20))
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}
