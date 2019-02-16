//
//  AutoTextField.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class AutoTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15);

    init(placeholder: String, textColor: UIColor, backgroundColor: UIColor) {
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false

        if (placeholder == "Password") {
            self.isSecureTextEntry = true
        }

        self.autocorrectionType = UITextAutocorrectionType.no;
        self.placeholder = placeholder
        self.backgroundColor = backgroundColor   
    }
    
    convenience init(placeholder: String, textColor: UIColor, backgroundColor: UIColor, borderColor: UIColor) {
        self.init(placeholder: placeholder, textColor: textColor, backgroundColor: backgroundColor)
        
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.padding)
    }
        
}
