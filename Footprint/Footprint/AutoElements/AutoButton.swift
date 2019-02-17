//
//  AutoButton.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class AutoButton: UIButton {
    
    let titleColor:UIColor
    let pressedTitleColor:UIColor
    
    init(text: String, titleColor: UIColor, backgroundColor: UIColor) {
        self.titleColor = backgroundColor
        self.pressedTitleColor = backgroundColor.darker(by: 10)!

        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setTitle(text, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.layer.cornerRadius = 4
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? self.pressedTitleColor : self.titleColor
        }
    }

    
}
