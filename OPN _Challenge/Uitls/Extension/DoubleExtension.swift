//
//  DoubleExtension.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 13/4/2567 BE.
//

import Foundation

extension Double {
    var oneDecimalPlace: String {
        return self.toDecimal(digit: 1)
    }
    
    var toString: String {
        return self.toDecimal(digit: 0)
    }
    
    func toDecimal(digit: Int = 2) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = digit
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
