//
//  TripConfirm.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class TripConfirm: UIView {
    
    let confirm_button = AutoButton(text: "Confirm Trip", titleColor: UIColor.white, backgroundColor: LoginVC.primaryGreen)
    let cover_view = AutoView()
    var cover_constraints:[NSLayoutConstraint]!
    
    init() {
        super.init(frame: .zero)
        super.translatesAutoresizingMaskIntoConstraints = false
        
        self.cover_view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        
        self.backgroundColor = UIColor.white
        self.addSubview(self.confirm_button)
        self.addSubview(self.cover_view)
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.cover_constraints = FLayoutConstraint.paddingPositionConstraints(view: self.cover_view, sides: [.left, .top, .right, .bottom], padding: 0)
        
        self.addConstraints(self.cover_constraints)
        self.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.confirm_button, sides: [.left, .right], padding: 20))
        self.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.confirm_button, sides: [.top, .bottom], padding: 10))
        self.addConstraint(FLayoutConstraint.constantConstraint(view: self, attribute: .height, value: UIScreen.main.bounds.height * 0.1))
    }
    
    func changeButtonState(enable: Bool) {
        if (enable) {
            self.cover_view.removeFromSuperview()
        } else {
            self.addSubview(self.cover_view)
        }
    }
    
}
