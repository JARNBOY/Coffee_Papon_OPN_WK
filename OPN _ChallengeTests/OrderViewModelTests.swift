//
//  OrderViewModelTests.swift
//  OPN _ChallengeTests
//
//  Created by Papon Supamongkonchai on 15/4/2567 BE.
//

import XCTest
@testable import OPN__Challenge

final class OrderViewModelTests: XCTestCase {
    
    var viewModel: OrderViewModel!
    var mockService: MockCoffeeAPIService!
    
    override func setUp() {
        super.setUp()
        mockService = MockCoffeeAPIService()
        viewModel = OrderViewModel(service: mockService, selectedProduct: mockOrders)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testInitialState() {
        // Assert
        XCTAssertEqual(viewModel.stateUI, .idle)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.selectedProduct.count, 2)
    }
    
    func testTotalPrice() {
        // Arrange
        let priceFromMock = 250.0
        
        // Act
        let totalPrice = viewModel.totalPrice
        
        // Assert
        XCTAssertEqual(totalPrice, priceFromMock)
    }
    
    func testRequestMakeOrderStatusSuccess() {
        // Arrange
        let coordinator = MockAppCoordinator()
        
        // Act
        mockService.returnSuccessResponseRequestMakeOrder(status: "Success")
        viewModel.requestMakeOrder(coordinator: coordinator)
        
        // Assert
        XCTAssertEqual(viewModel.stateUI, .loading)
        
        // Act
        viewModel.stateUI = .success
        viewModel.openSuccessMakeOrder(coordinator: coordinator)
       
        // Assert
        XCTAssertEqual(viewModel.stateUI, .success)
        XCTAssertTrue(coordinator.presentSheetCalled)
        
    }
    
    func testRequestMakeOrderStatusFailure() {
        // Arrange
        let errorMessage = "Network error"
        let coordinator = MockAppCoordinator()
        
        // Act
        viewModel.requestMakeOrder(coordinator: coordinator)
        mockService.returnFailureResponse(error: errorMessage)
        
        // Assert
        XCTAssertEqual(viewModel.stateUI, .loading)
        
        // Act
        viewModel.stateUI = .error
        viewModel.errorMessage = errorMessage
        
        // Assert
        XCTAssertEqual(viewModel.stateUI, .error)
        XCTAssertNotNil(viewModel.errorMessage)
    }
}

