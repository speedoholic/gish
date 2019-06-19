//
//  Double+Extension.swift
//  Gish
//
//  Created by Kushal Ashok on 2019/6/20.
//  Copyright © 2019 Kushal Ashok. All rights reserved.
//

import Foundation


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
