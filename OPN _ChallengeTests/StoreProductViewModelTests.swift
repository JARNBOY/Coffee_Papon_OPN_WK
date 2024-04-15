//
//  StoreProductViewModelTests.swift
//  OPN _ChallengeTests
//
//  Created by Papon Supamongkonchai on 15/4/2567 BE.
//

import XCTest
@testable import OPN__Challenge

class StoreProductViewModelTests: XCTestCase {
    
    var viewModel: StoreProductViewModel!
    var mockService: MockCoffeeAPIService!
    
    override func setUp() {
        super.setUp()
        mockService = MockCoffeeAPIService()
        viewModel = StoreProductViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testInitializeSelectedProduct() {
        // Arrange
        let product1 = mockProduct1
        let product2 = mockProduct2
        let viewModel = StoreProductViewModel(service: mockService)
        viewModel.displayStore = StoreProductModel.ViewModel(storeInfo: nil, productsInfo: [product1, product2])
        
        // Act
        viewModel.initializeSelectedProduct()
        
        // Assert
        XCTAssertEqual(viewModel.selectedProduct.count, 2)
        XCTAssertEqual(viewModel.selectedProduct[product1]?.qty, 0)
        XCTAssertEqual(viewModel.selectedProduct[product1]?.isSelected, false)
        XCTAssertEqual(viewModel.selectedProduct[product2]?.qty, 0)
        XCTAssertEqual(viewModel.selectedProduct[product2]?.isSelected, false)
    }
    
    func testIncrementAndDecrementSelectedProduct() {
        // Arrange
        let product1 = mockProduct1
        let viewModel = StoreProductViewModel(service: mockService)
        viewModel.displayStore = StoreProductModel.ViewModel(storeInfo: nil, productsInfo: [product1])
        viewModel.initializeSelectedProduct()
        
        // Act
        viewModel.incrementSelectedProduct(for: product1)
        
        // Assert
        XCTAssertEqual(viewModel.selectedProduct[product1]?.qty, 1)
        XCTAssertEqual(viewModel.selectedProduct[product1]?.isSelected, true)
        
        // Act
        viewModel.decrementSelectedProduct(for: product1)
        
        // Assert
        XCTAssertEqual(viewModel.selectedProduct[product1]?.qty, 0)
        XCTAssertEqual(viewModel.selectedProduct[product1]?.isSelected, false)
    }
    
    func testFeedAllStoreAPI() {
        // Arrange
        guard 
            let mockStore = resultMockToStoreInfoRequestStatusSuccess(),
            let mockProducts = resultMockJSONResponseProductInfosRequestStatusSuccess()
        else {
            return
        }
                
        let storeInfo: StoreInfo = mockStore
        let products: [ProductInfo] = mockProducts
        // Act
        mockService.returnSuccessResponse(storeInfo: storeInfo, productsInfo: products)
        viewModel.feedAllStoreAPI()
        
        // Assert
        XCTAssertEqual(viewModel.stateUI, .loading)
        XCTAssertNil(viewModel.displayStore)
        
        // Act
        viewModel.displayStore = StoreProductModel.ViewModel(
            storeInfo: storeInfo,
            productsInfo: products
        )
        viewModel.initializeSelectedProduct()
        viewModel.stateUI = .success
        
        // Assert
        XCTAssertEqual(viewModel.stateUI, .success)
        XCTAssertNotNil(viewModel.displayStore)
        XCTAssertEqual(viewModel.displayStore?.storeInfo, storeInfo)
        XCTAssertEqual(viewModel.displayStore?.productsInfo?.count, 2)
        XCTAssertEqual(viewModel.selectedProduct.count, 2)
    }
    
    func testFeedAllStoreAPIFailure() {
        // Arrange
        let errorMessage = "Network error"
        
        // Act
        mockService.returnFailureResponse(error: errorMessage)
        viewModel.feedAllStoreAPI()
        
        // Assert
        XCTAssertEqual(viewModel.stateUI, .loading)
        XCTAssertNil(viewModel.errorMessage)
        
        // Act
        viewModel.errorMessage = errorMessage
        viewModel.stateUI = .error
        
        // Assert
        XCTAssertEqual(viewModel.stateUI, .error)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, errorMessage)
    }
}

class MockCoffeeAPIService: CoffeeAPIService {
    private var successResponse: (StoreInfo?, [ProductInfo])?
    private var errorResponse: String?
    
    func feedAllDataStore(success: @escaping (StoreInfo?, [ProductInfo]?) -> Void, fail: @escaping (String?) -> Void) {
        if let (storeInfo, productsInfo) = successResponse {
            success(storeInfo, productsInfo)
        } else if let error = errorResponse {
            fail(error)
        }
    }
    
    func returnSuccessResponse(storeInfo: StoreInfo, productsInfo: [ProductInfo]) {
        successResponse = (storeInfo, productsInfo)
    }
    
    func returnFailureResponse(error: String) {
        errorResponse = error
    }
}
