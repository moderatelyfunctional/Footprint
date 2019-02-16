//
//  TripScrollView.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class TripScrollView: UIScrollView {
    
    let contentView = AutoView()
    
    let firstView = AutoView()
    let secondView = AutoView()
    let thirdView = AutoView()
    
    init() {
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.firstView.backgroundColor = UIColor.yellow
        self.secondView.backgroundColor = UIColor.red
        self.thirdView.backgroundColor = UIColor.brown
        
        self.backgroundColor = UIColor.white
        self.contentSize = TripDetails.size
        
        self.isUserInteractionEnabled = true
        self.isPagingEnabled = true
        self.isScrollEnabled = true
        
        self.addSubview(self.contentView)
        self.addSubview(self.firstView)
        self.addSubview(self.secondView)
        self.addSubview(self.thirdView)
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.contentView, sides: [.left, .top, .right, .bottom], padding: 0))
        self.addConstraint(FLayoutConstraint.constantConstraint(view: self.contentView, attribute: .height, value: TripDetails.size.height))
        
        self.addConstraint(FLayoutConstraint.constantConstraint(view: self.firstView, attribute: .width, value: TripDetails.size.width))
        self.addConstraint(FLayoutConstraint.equalConstraint(firstView: self, secondView: self.contentView, attribute: .height))
        self.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.firstView, sides: [.left, .top, .bottom], padding: 0))
        
        self.addConstraint(FLayoutConstraint.constantConstraint(view: self.secondView, attribute: .width, value: TripDetails.size.width))
        self.addConstraint(FLayoutConstraint.horizontalSpacingConstraint(leftView: self.firstView, rightView: self.secondView, spacing: 0))
        self.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.secondView, sides: [.top, .bottom], padding: 0))
        
        self.addConstraint(FLayoutConstraint.constantConstraint(view: self.thirdView, attribute: .width, value: TripDetails.size.width))
        self.addConstraint(FLayoutConstraint.horizontalSpacingConstraint(leftView: self.secondView, rightView: self.thirdView, spacing: 0))
        self.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.thirdView, sides: [.right, .top, .bottom], padding: 0))
    }
    
}
