//
//  StoreProductViewModel.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 13/4/2567 BE.
//

import Foundation
import SwiftUI

enum StoreProductModel {
    enum stateUI: Equatable {
        case idle
        case loading
        case success
        case error
    }
    
    struct ViewModel {
        let storeInfo: StoreInfo?
        let productsInfo: [ProductInfo]?
    }
    
    struct OrderInfo: Hashable {
        var qty: Int
        var isSelected: Bool
        var info: ProductInfo
    }
}

final class StoreProductViewModel: ObservableObject {
    @Published var displayStore: StoreProductModel.ViewModel?
    @Published var stateUI: StoreProductModel.stateUI = .idle
    @Published var errorMessage: String?
    @Published var selectedProduct: [ProductInfo: StoreProductModel.OrderInfo] = [:]
    
    private let service: CoffeeAPIService
    
    init(service: CoffeeAPIService) {
        self.service = service
    }
    
    func openOrderScreen(coordinator: AppCoordinator) {
        let selectProductOreder: [StoreProductModel.OrderInfo] = selectedProduct.compactMap { _, orderInfo in
            guard orderInfo.qty > 0 && orderInfo.isSelected else { return nil }
            return orderInfo
        }
        coordinator.push(.order(selectedProduct: selectProductOreder))
    }
    
    func initializeSelectedProduct() {
        if let products = displayStore?.productsInfo {
            selectedProduct = products.reduce(into: [:]) { result, product in
                result[product] = StoreProductModel.OrderInfo(qty: 0, isSelected: false, info: product)
            }
        }
    }
    
    func incrementSelectedProduct(for product: ProductInfo) {
        if var orderInfo = selectedProduct[product] {
            orderInfo.qty += 1
            if orderInfo.qty > 0 {
                orderInfo.isSelected = true
            }
            selectedProduct[product] = orderInfo
        }
    }
    
    func decrementSelectedProduct(for product: ProductInfo) {
        if var orderInfo = selectedProduct[product], orderInfo.qty > 0 {
            orderInfo.qty -= 1
            if orderInfo.qty == 0 {
                orderInfo.isSelected = false
            }
            selectedProduct[product] = orderInfo
        }
    }
    
}

extension StoreProductViewModel {
    func feedAllStoreAPI() {
        if stateUI == .idle {
            stateUI = .loading
            self.service.feedAllDataStore { storeInfo, productsInfo in
                DispatchQueue.main.async {
                    self.displayStore = StoreProductModel.ViewModel(
                        storeInfo: storeInfo,
                        productsInfo: productsInfo
                    )
                    self.initializeSelectedProduct()
                    self.stateUI = .success
                }
                
            } fail: { error in
                DispatchQueue.main.async {
                    self.stateUI = .error
                    self.errorMessage = error ?? "Faillllll"
                }
            }
        }
    }
}
