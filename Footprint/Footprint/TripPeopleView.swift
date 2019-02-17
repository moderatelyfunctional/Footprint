//
//  TripPeopleView.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class TripPeopleView: UIView {
    
    let textLabel = AutoLabel(text: "1 person(s)", textColor: UIColor.black)
    let iconView = UIImageView(image: UIImage(named: "people"))
    
    let plusView = UIImageView(image: UIImage(named: "plus"))
    let minusView = UIImageView(image: UIImage(named: "minus"))
    var n_people:Int = 1
        
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.iconView.translatesAutoresizingMaskIntoConstraints = false
        self.plusView.translatesAutoresizingMaskIntoConstraints = false
        self.minusView.translatesAutoresizingMaskIntoConstraints = false
        
        self.textLabel.font = UIFont(name: "Menlo", size: 20)
        self.iconView.contentMode = .scaleAspectFit
        self.plusView.contentMode = .scaleAspectFit
        self.minusView.contentMode = .scaleAspectFit
        
        self.plusView.isUserInteractionEnabled = true
        self.minusView.isUserInteractionEnabled = true
        
        let addOne = UITapGestureRecognizer(target: self, action: #selector(TripPeopleView.addOne))
        let minusOne = UITapGestureRecognizer(target: self, action: #selector(TripPeopleView.minusOne))
        
        self.plusView.addGestureRecognizer(addOne)
        self.minusView.addGestureRecognizer(minusOne)
        
        self.addSubview(self.textLabel)
        self.addSubview(self.iconView)
        self.addSubview(self.plusView)
        self.addSubview(self.minusView)
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.addConstraint(FLayoutConstraint.paddingPositionConstraint(view: self.textLabel, side: .top, padding: 20))
        self.addConstraint(FLayoutConstraint.horizontalAlignConstraint(firstView: self.textLabel, secondView: self))
        
        self.addConstraint(FLayoutConstraint.fillYConstraints(view: self.iconView, heightRatio: 0.3))
        self.addConstraint(FLayoutConstraint.verticalSpacingConstraint(upperView: self.textLabel, lowerView: self.iconView, spacing: 30))
        self.addConstraint(FLayoutConstraint.horizontalAlignConstraint(firstView: self.iconView, secondView: self))
        
        self.addConstraint(FLayoutConstraint.verticalAlignConstraint(firstView: self.minusView, secondView: self.iconView))
        self.addConstraint(FLayoutConstraint.fillXConstraints(view: self.minusView, widthRatio: 0.15))
        self.addConstraint(FLayoutConstraint.fillYConstraints(view: self.minusView, heightRatio: 0.15))
        self.addConstraint(FLayoutConstraint.paddingPositionConstraint(view: self.minusView, side: .left, padding: 80))

        self.addConstraint(FLayoutConstraint.verticalAlignConstraint(firstView: self.plusView, secondView: self.iconView))
        self.addConstraint(FLayoutConstraint.fillXConstraints(view: self.plusView, widthRatio: 0.15))
        self.addConstraint(FLayoutConstraint.fillYConstraints(view: self.plusView, heightRatio: 0.15))
        self.addConstraint(FLayoutConstraint.paddingPositionConstraint(view: self.plusView, side: .right, padding: 80))
    }
    
    @objc func addOne() {
        if (self.n_people >= 8) {
            return
        }
        self.n_people += 1
        self.textLabel.text = "\(self.n_people) person(s)"
    }
    
    @objc func minusOne() {
        if (self.n_people == 1) {
            return
        }
        self.n_people -= 1
        self.textLabel.text = "\(self.n_people) person(s)"
    }
}
