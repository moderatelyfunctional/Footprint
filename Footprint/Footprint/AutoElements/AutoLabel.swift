//
//  AutoLabel.swift
//  Footprint
//
//  Created by Jing Lin on 2/15/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class AutoLabel: UILabel {
    
    init(text: String, textColor: UIColor) {
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.text = text
        self.textColor = textColor
        self.font = UIFont(name: "Avenir", size: 36)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
