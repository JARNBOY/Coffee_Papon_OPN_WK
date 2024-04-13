//
//  DateExtension.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import Foundation

let hhmmssSSSFormat = "HH:mm:ss.SSSZ"
let openCloseTimeFormat = "h:mm a"

extension Date {
    func toString(using format: String = hhmmssSSSFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
