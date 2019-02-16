//
//  HomeViewController.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class HomeViewController: DismissViewController {

    let searchField = AutoTextField(
        placeholder: "Where to?",
        textColor: UIColor.black,
        backgroundColor: UIColor.white,
        borderColor: UIColor.gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.view.backgroundColor = UIColor.white
        
        setupSearch()
    }
    
    func setupSearch() {
        self.view.addSubview(self.searchField)
        
        self.view.addConstraint(FLayoutConstraint.paddingPositionConstraint(view: self.searchField, side: .top, padding: 84))
        self.view.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.searchField, sides: [.left, .right], padding: 40))
    }


}
