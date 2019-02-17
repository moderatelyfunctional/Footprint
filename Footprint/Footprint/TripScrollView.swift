//
//  TripScrollView.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class TripScrollView: UIScrollView, TripSelectionProtocol {
    
    let contentView = AutoView()
    
    let firstView = TripMileView()
    let secondView = TripPeopleView()
    let thirdView = TripCars()
    
    var selected_fields:[Bool] = [false, false, false]
    
    var trip_confirm_delegate:TripConfirmProtocol!
    
    init() {
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.firstView.trip_selected_delegate = self
        self.secondView.trip_selected_delegate = self
        self.thirdView.trip_selected_delegate = self
        
        self.backgroundColor = UIColor.white
        self.contentSize = TripDetails.size
        
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
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
    
    func selectedElement(index: Int) {
        self.selected_fields[index] = true
        var all_selected = true
        for curr_state in self.selected_fields {
            all_selected = all_selected && curr_state
        }
        if (all_selected) {
            self.trip_confirm_delegate.confirmTrip()
        }
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
