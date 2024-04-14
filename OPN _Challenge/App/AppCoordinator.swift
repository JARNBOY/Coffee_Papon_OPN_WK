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
    var navPath: [Screen] { get set }
    func start() -> AnyView
    func popToRoot()
    func showSplashScreen()
    func showStoreProductScreen()
    func showOrderScreen()
    func navigateOrderScreen() -> AnyView
    func showSuccessSheet()
}

final class AppCoordinator: ObservableObject, AppCoordinatorProtocol {
    @Published var navPath: [Screen] = []
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
            return viewFactory.createOrderScreenView(coordinator: self)
        case .success:
            return viewFactory.createSuccessSheet(coordinator: self)
        }
    }
    
    func popToRoot() {
        self.navPath.removeAll()
    }

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

    func showOrderScreen() {
        withAnimation {
            currentScreen = .order
        }
    }
    
    func navigateOrderScreen() -> AnyView {
        navPath.append(.order)
        return viewFactory.createOrderScreenView(coordinator: self)
    }

    func showSuccessSheet() {
        withAnimation {
            currentScreen = .success
        }
    }
}
