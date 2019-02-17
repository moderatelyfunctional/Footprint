//
//  TripCars.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class TripCars: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    let data = [
        "Mazda", "Hyundai", "Honda", "Subaru",
        "Nissan", "Kia", "BMW", "Toyota",
        "Mercedes", "Ford" , "GM"
    ]
    var trip_selected_delegate:TripSelectionProtocol!
    
    init() {
        super.init(frame: .zero, style: .plain)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        cell.textLabel?.text = self.data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("The car type is \(self.data[indexPath.row])")
        self.trip_selected_delegate.selectedElement()
    }
    
}
