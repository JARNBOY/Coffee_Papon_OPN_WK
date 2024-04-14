//
//  AppCoordinator.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import Foundation
import SwiftUI

enum Screen: String {
    case splash, storeProduct, order, success
}

protocol AppCoordinatorProtocol: ObservableObject {
    func start() -> AnyView
    func showSplashScreen()
    func showStoreProductScreen()
    func navigateOrderScreen(selectedProduct: [StoreProductModel.OrderInfo]) -> AnyView
    func showSuccessSheet(onDismiss: (() -> Void)?) -> AnyView
}

final class AppCoordinator: ObservableObject, AppCoordinatorProtocol {
    @Published var currentScreen: Screen = .splash
    private let viewFactory: ViewFactory

    init(viewFactory: ViewFactory) {
        self.viewFactory = viewFactory
    }

    func start() -> AnyView {
        switch currentScreen {
        case .splash:
            return viewFactory.createSplashView(coordinator: self)
        case .storeProduct:
            return viewFactory.createStoreProductScreenView(coordinator: self)
        case .order:
            return viewFactory.createOrderScreenView(coordinator: self, 
                                                     selectedProduct: [])
        case .success:
            return viewFactory.createSuccessSheet(coordinator: self, onDismiss: nil)
        }
    }
    
    // For Change currentScreen RootView

    func showSplashScreen() {
        withAnimation {
            currentScreen = .splash
        }
    }

    func showStoreProductScreen() {
        withAnimation {
            currentScreen = .storeProduct
        }
    }
    
    // Navigate Something
    
    func navigateOrderScreen(selectedProduct: [StoreProductModel.OrderInfo]) -> AnyView {
        return viewFactory.createOrderScreenView(coordinator: self, 
                                                 selectedProduct: selectedProduct)
    }
    
    // Sheet SomeThing

    func showSuccessSheet(onDismiss: (() -> Void)?) -> AnyView {
        return viewFactory.createSuccessSheet(coordinator: self, onDismiss: onDismiss)
    }
}
