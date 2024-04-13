//
//  StringExtension.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import Foundation

extension String {
    var utf8Encoded: Data {
        if let data = data(using: .utf8) {
            return data
        }
        return Data()
    }
}

extension String {
    func toDate(format: String = hhmmssSSSFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = format
        
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
