//
//  ViewFactory.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import Foundation
import SwiftUI

protocol ViewFactory {
    func createSplashView(coordinator: any AppCoordinatorProtocol) -> AnyView
    func createStoreProductScreenView(coordinator: any AppCoordinatorProtocol) -> AnyView
    func createOrderScreenView(coordinator: any AppCoordinatorProtocol) -> AnyView
    func createSuccessSheet(coordinator: any AppCoordinatorProtocol) -> AnyView
    
}

struct DefaultViewFactory: ViewFactory {
    func createSplashView(coordinator: any AppCoordinatorProtocol) -> AnyView {
        AnyView(SplashView(coordinator: coordinator))
    }
    
    func createStoreProductScreenView(coordinator: any AppCoordinatorProtocol) -> AnyView {
        AnyView(StoreProductScreenView(coordinator: coordinator))
    }
    
    func createOrderScreenView(coordinator: any AppCoordinatorProtocol) -> AnyView {
        AnyView(OrderScreenView(coordinator: coordinator))
    }
    
    func createSuccessSheet(coordinator: any AppCoordinatorProtocol) -> AnyView {
        AnyView(SuccessSheetView(coordinator: coordinator))
    }
    
}
