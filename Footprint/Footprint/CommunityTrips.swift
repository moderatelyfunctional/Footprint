//
//  UserTrips.swift
//  Footprint
//
//  Created by Jing Lin on 2/17/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class CommunityTrips: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var trips:NSArray = []
    
    init() {
        super.init(frame: .zero, style: .plain)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        self.backgroundColor = UIColor.white
        
        self.separatorInset = .zero
        self.layoutMargins = .zero
        self.separatorStyle = .none
        self.allowsSelection = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = self.trips[indexPath.row] as! NSDictionary
        let userID = cellData["user_id"] as! Int
        let city = cellData["city"] as! String
        let car_type = cellData["car_type"] as! String
        let emissions = (cellData["emission"] as! Double).rounded(toPlaces: 3)
        let distance_walked = (cellData["dist_walked"] as! Double).rounded(toPlaces: 3)
        let end_time = cellData["end_time"] as! String
        let end_time_arr = end_time.components(separatedBy: " ")
        
        let cell = self.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        cell.textLabel!.text = "On \(end_time_arr[0]), User \(userID) saved \(emissions)g of Carbon by walking \(distance_walked) while driving a \(car_type) in \(city)."
        
        return cell
    }
    
}
