//
//  CoffeeAPIService.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 14/4/2567 BE.
//

import Foundation

protocol CoffeeAPIServiceProtocol {
    func feedAllDataStore(success: @escaping (StoreInfo, [ProductInfo]) -> (),
                          fail: @escaping (_ error: String?) -> ())
    func requestStore(success: @escaping (StoreInfo?) -> (), 
                      fail: @escaping (_ error: String?) -> ())
    func requestProducts(success: @escaping ([ProductInfo]?) -> (), 
                         fail: @escaping (_ error: String?) -> ())
    func requestMakeOrder(products: [ProductInfo],
                          deliveryAddress: String,
                          success: @escaping (String?) -> (),
                          fail: @escaping (_ error: String?) -> ())
}

class CoffeeAPIService: CoffeeAPIServiceProtocol {
    func feedAllDataStore(success: @escaping (StoreInfo, [ProductInfo]) -> (),
                          fail: @escaping (_ error: String?) -> ()) {
        // Create a dispatch group
        let dispatchGroup = DispatchGroup()
        var _error: String?
        var storeInfos: StoreInfo?
        var productInfos: [ProductInfo]?
        
        // Fetch data from the first API
        dispatchGroup.enter()
        requestStore { storeInfo in
            storeInfos = storeInfo
            dispatchGroup.leave()
        } fail: { error in
            _error = error
            dispatchGroup.leave()
        }
        // Fetch data from the second API
        dispatchGroup.enter()
        requestProducts { productInfo in
            productInfos = productInfo
            dispatchGroup.leave()
        } fail: { error in
            _error = error
            dispatchGroup.leave()
        }
        // Wait for both tasks to complete
        dispatchGroup.notify(queue: .main) {
            // Both tasks have completed, handle the results
            if let productInfos = productInfos, let storeInfos = storeInfos {
                success(storeInfos, productInfos)
            } else {
                fail(_error)
            }
        }
    }
    
    func requestStore(success: @escaping (StoreInfo?) -> (), fail: @escaping (_ error: String?) -> ()) {
        APIManager.shared.request(endpoint: "\(baseURL)/storeInfo", method: .get, headers: nil, body: nil) { result in
            switch result {
            case .success(let data):
                do {
                    let store = try JSONDecoder().decode(StoreInfo.self, from: data)
                    success(store)
                } catch {
                    print("Error decoding JSON: \(error)")
                    success(nil)
                }
            case .failure(let error):
                if error == ErrorType.failedLimitRequest {
                    // If Limit case we will use Mock follow Doc web
                    success(resultMockToStoreInfoRequestStatusSuccess())
                } else {
                    fail(error.errorDescription)
                }
            }
        }
    }
    
    func requestProducts(success: @escaping ([ProductInfo]?) -> (), fail: @escaping (_ error: String?) -> ()) {
        APIManager.shared.request(endpoint: "\(baseURL)/products", method: .get, headers: nil, body: nil) { result in
            switch result {
            case .success(let data):
                do {
                    let products = try JSONDecoder().decode([ProductInfo].self, from: data)
                    success(products)
                } catch {
                    print("Error decoding JSON: \(error)")
                    success(nil)
                }
            case .failure(let error):
                if error == ErrorType.failedLimitRequest {
                    // If Limit case we will use Mock follow Doc web
                    success(resultMockJSONResponseProductInfosRequestStatusSuccess())
                } else {
                    fail(error.errorDescription)
                }
            }
        }
    }
    
    func requestMakeOrder(products: [ProductInfo],
                          deliveryAddress: String,
                          success: @escaping (String?) -> (),
                          fail: @escaping (_ error: String?) -> ()) {
        
        let orderData = OrderData(
            products: products,
            deliveryAddress: deliveryAddress
        )

        let jsonBodyData = try? JSONEncoder().encode(orderData)
        let jsonString = String(data: jsonBodyData ?? Data(), encoding: .utf8)
        print(jsonString ?? "")
        
        APIManager.shared.request(endpoint: "\(baseURL)/order", method: .post, headers: nil, body: jsonBodyData) { result in
            switch result {
            case .success(let data):
                do {
                    let status = try JSONDecoder().decode(String.self, from: data)
                    success(status)
                } catch {
                    print("Error decoding JSON: \(error)")
                    success(nil)
                }
            case .failure(let error):
                if error == ErrorType.failedLimitRequest {
                    // If Limit case we will use Mock follow Doc web
                    success("Success")
                } else {
                    fail(error.errorDescription)
                }
            }
        }
    }
}
