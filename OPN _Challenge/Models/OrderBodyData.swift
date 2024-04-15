//
//  OrderBodyData.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 15/4/2567 BE.
//

import Foundation

struct OrderData: Codable {
    let products: [ProductInfo]
    let deliveryAddress: String
}
