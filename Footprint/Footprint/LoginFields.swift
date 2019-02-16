//
//  LoginFields.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class LoginFields: UIView {
    
    let emailField = AutoTextField(placeholder: "Email", textColor: UIColor.black, backgroundColor: UIColor.white)
    let passwordField = AutoTextField(placeholder: "Password", textColor: UIColor.black, backgroundColor: UIColor.white)
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
        self.addConstraint(FLayoutConstraint.paddingPositionConstraint(view: emailField, side: .top, padding: 0))
        self.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: emailField, sides: [.left, .right], padding: 40))
        self.addConstraint(FLayoutConstraint.verticalSpacingConstraint(upperView: emailField, lowerView: passwordField, spacing: 10))
        
        self.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: passwordField, sides: [.left, .right], padding: 40))
        self.addConstraint(FLayoutConstraint.verticalSpacingConstraint(upperView: passwordField, lowerView: loginButton, spacing: 50))
        
        self.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: loginButton, sides: [.left, .right, .bottom], padding: 40))
        self.addConstraint(FLayoutConstraint.constantConstraint(view: loginButton, attribute: .height, value: 40))
    }
}
