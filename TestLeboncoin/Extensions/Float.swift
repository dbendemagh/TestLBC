//
//  Float.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 25/09/2022.
//

import Foundation

extension Float {
    func floatToEuro() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "FR-fr")
        let price = numberFormatter.string(from: NSNumber(value: self))
        if let price = price {
            return "\(price) €"
        }
        
        return ""
    }
}
