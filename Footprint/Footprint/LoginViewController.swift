//
//  ViewController.swift
//  Footprint
//
//  Created by Jing Lin on 2/15/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    let loginField = LoginFields()
    var loginBottomConstraint:NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let google_url = GoogleMapsAPI.fetchDirectionURL(
            key: "AIzaSyDVuFQ5aAu0kEucO1FM09CaC7eUvLkbxvg",
            origin: "Disneyland",
            destination: "Universal Studios Hollywood")
//        let open_weather_url = "https://api.openweathermap.org/data/2.5/weather"
//        var params:Parameters = [:]
//        params["q"] = "London"
//        params["APPID"] = "939e6256985470a1d2127b1d40ec7717"

//        let fp_server_url = "http://ec2-3-17-206-47.us-east-2.compute.amazonaws.com:8000/signup/"
//        var params:Parameters = [:]
//        params["email"] = "hi@mit.edu"
//        params["password"] = "byebyebye"
        
        AF.request(google_url, method: .post, encoding: JSONEncoding.default).responseJSON {
            response in
            print(response.request)
            
            debugPrint(response)
        }
        
//        HttpClientAPI.instance().makeAPICall(url: "https://maps.googleapis.com/maps/api/directions/json?origin=Disneyland&destination=Universal+Studios+Hollywood&key=AIzaSyDVuFQ5aAu0kEucO1FM09CaC7eUvLkbxvg", params: nil, method: .POST, success: { (data, response, error) in
//            print("SUCCESS")
//            print(data)
//        }) { (data, response, error) in
//            print("FAILED")
//            print(String(bytes: data!, encoding: String.Encoding.utf8))
//            print("response is \(response)")
//            print("error is \(error)")
//        }
        
        setupBackground()
        setupTitle()
        setupLoginField()
        setupLoginListeners()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillAppear(notification: NSNotification?) {
        guard let keyboardFrame = notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let keyboardHeight: CGFloat
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        
        self.loginBottomConstraint.constant = -keyboardHeight
    }

    @objc func keyboardWillDisappear(notification: NSNotification?) {
        self.loginBottomConstraint.constant = 0
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

    func setupLoginField() {
        self.view.addSubview(self.loginField)
        self.view.addConstraints(FLayoutConstraint.paddingPositionConstraints(view: self.loginField, sides: [.left, .right], padding: 0))

        self.loginBottomConstraint = FLayoutConstraint.paddingPositionConstraint(view: self.loginField, side: .bottom, padding: 0)
        self.view.addConstraint(self.loginBottomConstraint)
    }

    func setupLoginListeners() {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        self.loginField.loginButton.addTarget(self, action: #selector(LoginViewController.postLoginUser), for: .touchUpInside)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    @objc func postLoginUser() {
        print("Hello shoudl call this")
    }

}
