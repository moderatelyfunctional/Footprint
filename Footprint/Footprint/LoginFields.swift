//
//  LoginFields.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class LoginFields: UIView {
    
    let emailField = AutoTextField(placeholder: "Email" textColor: UIColor.black, backgroundColor: UIColor.white)
    let passwordField = AutoTextField(placeholder: "Password" textColor: UIColor.black, backgroundColor: UIColor.white)
    let loginButton = AutoButton(text: "Log In", titleColor: UIColor.white, backgroundColor: LoginVC.primaryGreen)

    init() {
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(self.emailField)
        self.addSubview(self.passwordField)
        self.addSubview(self.loginButton)

        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func addConstraints() {
        self.view.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: loginButton, sides: [.left, .right, .bottom], padding: 40))
        self.view.addConstraint(FLayoutConstraint.constantConstraint(view: loginButton, attribute: .height, value: 40))

    }
}
