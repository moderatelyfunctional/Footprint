//
//  CommunityViewController.swift
//  Footprint
//
//  Created by Jing Lin on 2/17/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit
import Alamofire

class CommunityViewController: UIViewController {
    
    var latest_emission:Double!
    var cumulative_emission:Double!
    var elements:NSArray!
    
    let titleLabel = AutoLabel(text: "Community Trips", textColor: LoginVC.primaryGreen)
    let quitImage = UIImageView(image: UIImage(named: "x"))
    
    let communityTrips = CommunityTrips()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = UIColor.white
        
        var params:Parameters = [:]
        //        params["user_id"] = UserInfo.userID
        params["user_id"] = 7
        
        AF.request(FPServerAPI.commURL, method: .post, parameters: params).responseJSON {
            responseData in
            if (responseData.response?.statusCode == 200) {
                let data = responseData.result.value
                let JSON = data as! NSDictionary
                self.elements = JSON.object(forKey: "community_trips_recent_json") as! NSArray
                
                self.communityTrips.trips = self.elements
                self.communityTrips.reloadData()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(UserViewController.dismissViewController))
        
        self.quitImage.translatesAutoresizingMaskIntoConstraints = false
        self.quitImage.isUserInteractionEnabled = true
        self.quitImage.addGestureRecognizer(gestureRecognizer)
        
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.communityTrips)
        self.view.addSubview(self.quitImage)
        
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.titleLabel, sides: [.top, .left], padding: 45))

        self.view.addConstraint(FLayoutConstraint.verticalSpacingConstraint(upperView: self.titleLabel, lowerView: self.communityTrips, spacing: 20))
        self.view.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.communityTrips, sides: [.left, .right], padding: 30))
        self.view.addConstraint(FLayoutConstraint.paddingPositionConstraint(view: self.communityTrips, side: .bottom, padding: 20))
        
        self.view.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.quitImage, sides: [.top, .right], padding: 20))
    }
    
    @objc func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }

    
}
