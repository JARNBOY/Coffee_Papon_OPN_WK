//
//  DoubleExtension.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 13/4/2567 BE.
//

import Foundation

extension Double {
    var oneDecimalPlace: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
