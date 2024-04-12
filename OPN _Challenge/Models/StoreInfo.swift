//
//  StoreInfo.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import Foundation

struct StoreInfo: Codable {
    let name: String
    let rating: Double
    let openingTime: String
    let closingTime: String

    private enum CodingKeys: String, CodingKey {
        case name, rating, openingTime, closingTime
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        rating = try container.decode(Double.self, forKey: .rating)

        let openingTimeString = try container.decode(String.self, forKey: .openingTime)
        let closingTimeString = try container.decode(String.self, forKey: .closingTime)

        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        if let openingTimeDate = dateFormatter.date(from: openingTimeString) {
            openingTime = StoreInfo.formatTime(from: openingTimeDate)
        } else {
            openingTime = "N/A"
        }

        if let closingTimeDate = dateFormatter.date(from: closingTimeString) {
            closingTime = StoreInfo.formatTime(from: closingTimeDate)
        } else {
            closingTime = "N/A"
        }
    }

    static private func formatTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
}
