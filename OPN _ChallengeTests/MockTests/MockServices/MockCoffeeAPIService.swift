//
//  MockCoffeeAPIService.swift
//  OPN _ChallengeTests
//
//  Created by Papon Supamongkonchai on 15/4/2567 BE.
//

import Foundation
@testable import OPN__Challenge

class MockCoffeeAPIService: CoffeeAPIServiceProtocol {
    private var successResponseFeedAllDataStore: (StoreInfo, [ProductInfo])?
    private var successResponseRequestMakeOrder: String?
    private var errorResponse: String?
    
    // CoffeeAPIServiceProtocol
    func feedAllDataStore(success: @escaping (StoreInfo, [ProductInfo]) -> (), fail: @escaping (String?) -> ()) {
        if let (storeInfo, productsInfo) = successResponseFeedAllDataStore {
            success(storeInfo, productsInfo)
        } else if let error = errorResponse {
            fail(error)
        }
    }
    
    func requestStore(success: @escaping (StoreInfo?) -> (), fail: @escaping (String?) -> ()) {
        if let storeInfoMock = resultMockToStoreInfoRequestStatusSuccess() {
            success(storeInfoMock)
        } else if let error = errorResponse {
            fail(error)
        }
    }
    
    func requestProducts(success: @escaping ([ProductInfo]?) -> (), fail: @escaping (String?) -> ()) {
        if let productsMock = resultMockJSONResponseProductInfosRequestStatusSuccess() {
            success(productsMock)
        } else if let error = errorResponse {
            fail(error)
        }
    }
    
    func requestMakeOrder(products: [ProductInfo], deliveryAddress: String, success: @escaping (String?) -> (), fail: @escaping (String?) -> ()) {
        if let status = successResponseRequestMakeOrder {
            success(status)
        } else if let error = errorResponse {
            fail(error)
        }
    }
}
extension MockCoffeeAPIService {
    // Response Closure Mock
    func returnSuccessResponseFeedAllDataStore(storeInfo: StoreInfo, productsInfo: [ProductInfo]) {
        successResponseFeedAllDataStore = (storeInfo, productsInfo)
    }
    
    func returnSuccessResponseRequestMakeOrder(status: String) {
        successResponseRequestMakeOrder = status
    }
    
    func returnFailureResponse(error: String) {
        errorResponse = error
    }
}
