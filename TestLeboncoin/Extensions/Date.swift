//
//  Date.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 25/09/2022.
//

import Foundation

extension Date {
    func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "FR-fr")
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        let dateString = formatter.string(from: self)
        let capitalizedString = dateString.prefix(1).capitalized + dateString.dropFirst()
        return capitalizedString
    }
}
