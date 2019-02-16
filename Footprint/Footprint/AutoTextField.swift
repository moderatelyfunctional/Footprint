//
//  AutoTextField.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class AutoTextField: UITextField {
    
    init(placeholder: String, textColor: UIColor, backgroundColor: UIColor) {
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false

        if (placeholder == 'Password') {
            self.isSecureTextEntry = true
        }

        self.placeholder = placeholder
        self.backgroundColor = backgroundColor   
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}
