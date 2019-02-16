//
//  GoogleMapsDecoder.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

struct Directions: Decodable {
    let geocoded_waypoints: [WayPoint]
    let routes: [Route]
    let status: String
}

struct Route: Decodable {
    let bounds: Bound
    let copyrights: String
    let legs: [Leg]
    let overview_polyline: Polyline
    let summary: String
    let warnings: [String]
    let waypoint_order: [String]
    
}

struct Leg: Decodable {
    let distance: TextVal
    let duration: TextVal
    let end_address: String
    let end_location: Coord
    let start_address: String
    let start_location: Coord
    let steps: [Step]
    let traffic_speed_entry: [String]
    let via_waypoint: [String]
}

struct Step: Decodable {
    let distance: TextVal
    let duration: TextVal
    let end_location: Coord
    let html_instructions: String
    let polyline: Polyline
    let start_location: Coord
    let travel_mode: String
}

struct TextVal: Decodable {
    let text: String
    let value: Int
}

struct Polyline: Decodable {
    let points: String
}

struct WayPoint: Decodable {
    let geocoder_status: String
    let place_id: String
    let types: [String]
}

struct Bound: Decodable {
    let northeast: Coord
    let southwest: Coord
}

struct Coord: Decodable {
    let lat: Double
    let lng: Double
}
