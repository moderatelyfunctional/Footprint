//
//  FPServerAPI.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import Foundation

class FPServerAPI:NSObject {

    static let baseURL = "http://ec2-3-17-206-47.us-east-2.compute.amazonaws.com:8000"
    
    static let loginURL = "\(baseURL)/login/"
    static let addURL = "\(baseURL)/add_trip/"
    static let statsURL = "\(baseURL)/stats/"
    static let commURL = "\(baseURL)/community/"
}
