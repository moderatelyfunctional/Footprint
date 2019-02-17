//
//  CustomCell.swift
//  Footprint
//
//  Created by Jing Lin on 2/17/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
