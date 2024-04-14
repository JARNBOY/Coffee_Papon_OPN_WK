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
}

final class StoreProductViewModel: ObservableObject {
    @Published var displayStore: StoreProductModel.ViewModel?
    @Published var stateUI: StoreProductModel.stateUI = .idle
    @Published var errorMessage: String?
//    @Published var products: [ProductInfo]
//    @Published var selectedProduct: [ProductInfo: Int] = [:]
    var coordinator: any AppCoordinatorProtocol
    private let service: CoffeeAPIService
    
    init(coordinator: any AppCoordinatorProtocol, service: CoffeeAPIService) {
        self.coordinator = coordinator
        self.service = service
    }
    
    func openOrderScreen() -> AnyView {
        coordinator.navigateOrderScreen()
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
