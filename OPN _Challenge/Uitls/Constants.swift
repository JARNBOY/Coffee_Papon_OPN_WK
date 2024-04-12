//
//  Constants.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import Foundation

var mockJSONResponseStoreInfo: Data {
    return """
    {
      "name": "The Coffee Shop",
      "rating": 4.5,
      "openingTime": "15:01:01.772Z",
      "closingTime": "19:45:51.365Z"
    }
    """.utf8Encoded
}

func resultMockToStoreInfoRequestStatusSuccess() -> StoreInfo? {
    do {
        let products = try JSONDecoder().decode(StoreInfo.self, from: mockJSONResponseStoreInfo)
        print(products)
        return products
    } catch {
        print("Error decoding JSON: \(error)")
        return nil
    }
}
