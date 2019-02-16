//
//  GoogleMapsAPI.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import Foundation

class GoogleMapsAPI:NSObject {

    static let baseDirectionURL = "https://maps.googleapis.com/maps/api/directions/json"
    
    static func fetchDirectionURL(key: String, origin: String, destination: String) -> URL {
        var components = URLComponents(string: self.baseDirectionURL)!
        let key_item = URLQueryItem(name: "key", value: key)
        let origin_item = URLQueryItem(name: "origin", value: origin)
        let destination_item = URLQueryItem(name: "destination", value: destination)
        
        components.queryItems = [key_item, origin_item, destination_item]
        
        return components.url!
    }
    
}
