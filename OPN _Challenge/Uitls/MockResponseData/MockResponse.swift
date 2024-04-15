//
//  MockResponse.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import Foundation

let mockProduct1 = ProductInfo(name: "Latte", price: 50.0, imageUrl: "https://www.nespresso.com/ncp/res/uploads/recipes/nespresso-recipes-Latte-Art-Tulip.jpg")

let mockProduct2 = ProductInfo(name: "Dark Tiramisu Mocha", price: 75.0, imageUrl: "https://www.nespresso.com/shared_res/mos/free_html/sg/b2b/b2ccoffeerecipes/listing-image/image/dark-tiramisu-mocha.jpg"
)

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

var mockJSONResponseProductInfos: Data {
    return """
    [
      {
        "name": "Latte",
        "price": 50,
        "imageUrl": "https://www.nespresso.com/ncp/res/uploads/recipes/nespresso-recipes-Latte-Art-Tulip.jpg"
      },
      {
        "name": "Dark Tiramisu Mocha",
        "price": 75,
        "imageUrl": "https://www.nespresso.com/shared_res/mos/free_html/sg/b2b/b2ccoffeerecipes/listing-image/image/dark-tiramisu-mocha.jpg"
      }
    ]
    """.utf8Encoded
}

func resultMockJSONResponseProductInfosRequestStatusSuccess() -> [ProductInfo]? {
    do {
        let products = try JSONDecoder().decode([ProductInfo].self, from: mockJSONResponseProductInfos)
        print(products)
        return products
    } catch {
        print("Error decoding JSON: \(error)")
        return nil
    }
}
