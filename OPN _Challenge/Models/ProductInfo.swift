//
//  ProductInfo.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import Foundation

struct ProductInfo: Codable, Hashable, Equatable {
    let name: String
    let price: Double
    let imageUrl: String
}
