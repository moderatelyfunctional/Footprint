//
//  Constants.swift
//  Footprint
//
//  Created by Jing Lin on 2/15/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit
import AVFoundation

struct LoginVC {
    
    static let filterColor:CGColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6).cgColor
    static let primaryGreen:UIColor = UIColor(red: 73.0 / 255, green: 160.0 / 255, blue: 101.0 / 255, alpha: 1.0)
    
    static let textFieldWhite:UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.85)
}

struct TripDetails {
    
    static let size:CGSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.25)
    
}

struct UserInfo {
    
    static var userID:Int = -1
    static var currPosition:(Double, Double) = (37.33233141, -122.031218)
    
}
