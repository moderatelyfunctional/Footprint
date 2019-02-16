//
//  MapsViewController.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class MapsViewController: UIViewController {
    
    override func viewDidLoad() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = UIColor.red
        
        self.view.backgroundColor = UIColor.green
        
        self.view.addSubview(view)
    }
    
}
