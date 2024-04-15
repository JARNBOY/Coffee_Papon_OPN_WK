//
//  OrderViewModel.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 15/4/2567 BE.
//

import Foundation

enum OrderModel {
    enum stateUI: Equatable {
        case idle
        case loading
        case success
        case error
    }
}

final class OrderViewModel: ObservableObject {

    @Published var stateUI: OrderModel.stateUI = .idle
    @Published var errorMessage: String?
    @Published var selectedProduct: [StoreProductModel.OrderInfo]
    
    var totalPrice: Double {
        var totalP = 0.0
        for order in selectedProduct {
            totalP += order.info.price * Double(order.qty)
        }
        return totalP
    }
    private let service: CoffeeAPIServiceProtocol
    
    init(service: CoffeeAPIServiceProtocol,
         selectedProduct: [StoreProductModel.OrderInfo]) {
        self.service = service
        self.selectedProduct = selectedProduct
    }
    
    func openSuccessMakeOrder(coordinator: any AppCoordinatorProtocol) {
        coordinator.present(sheet: .success(onDismiss: {
            coordinator.dismissSheet()
            coordinator.popToRoot()
        }))
    }
    
}

extension OrderViewModel {
    func requestMakeOrder(coordinator: any AppCoordinatorProtocol, deliveryAddress: String = "CDC O4 Office, Bangkapi, Bangkok, 10310") {
        let products: [ProductInfo] = selectedProduct.map({ $0.info })
        stateUI = .loading
        service.requestMakeOrder(products: products, deliveryAddress: deliveryAddress) { status in
            DispatchQueue.main.async {
                if status == "Success" {
                    self.openSuccessMakeOrder(coordinator: coordinator)
                }
                self.stateUI = .success
            }
        } fail: { error in
            DispatchQueue.main.async {
                self.errorMessage = error
                self.stateUI = .error
            }
        }

    }
}

