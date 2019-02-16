//
//  ViewController.swift
//  Footprint
//
//  Created by Jing Lin on 2/15/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupBackground()
        setupTitle()
    }

    func setupBackground() {
        let backgroundImg = UIImage(named: "main_background")
        let backgroundView = UIImageView(frame: UIScreen.main.bounds)
        
        let whiteLayer = CALayer()
        whiteLayer.frame = UIScreen.main.bounds
        whiteLayer.backgroundColor = LoginVC.filterColor
        
        backgroundView.image = backgroundImg
        backgroundView.contentMode = .scaleAspectFill
        backgroundView.layer.addSublayer(whiteLayer)
        self.view.addSubview(backgroundView)
    }
    
    func setupTitle() {
        let loginLabel = AutoLabel(text: "Footprint", textColor: LoginVC.primaryGreen)

        self.view.addSubview(loginLabel)

        self.view.addConstraint(FLayoutConstraint.paddingPositionConstraint(view: loginLabel, side: .top, padding: 80))
        self.view.addConstraint(FLayoutConstraint.horizontalAlignConstraint(firstView: self.view, secondView: loginLabel))
    }

}

