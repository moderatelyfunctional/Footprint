//
//  Number.swift
//  Footprint
//
//  Created by Jing Lin on 2/17/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


