//
//  AppCoordinator.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import Foundation
import SwiftUI
//import SwiftNetwork

protocol AppCoordinatorProtocol: ObservableObject {
    func start() -> AnyView
    
    func showSplashScreen()
    func showStoreProductScreen()
    func showOrderScreen()
    func showSuccessSheet()

//    func openPrivacyPolicy(_ urlString: String)
//    func openTermsOfUse(_ urlString: String)
//    func openExternalLink(_ urlString: String)
//    func openXapo(_ urlString: String)
}

final class AppCoordinator: ObservableObject, AppCoordinatorProtocol {
    enum Screen {
        case splash, storeProduct, order, success
    }

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

    func showSuccessSheet() {
        withAnimation {
            currentScreen = .success
        }
    }

//    func showDetailsView(repository: Repository, viewModel: RepositoryViewModel) -> AnyView {
//        return viewFactory.createRepositoryDetailView(repository: repository, viewModel: viewModel, coordinator: self)
//    }

//    func showShareScreen(with url: String) -> AnyView {
//        return viewFactory.createShareSheet(with: url)
//    }

//    func openPrivacyPolicy(_ urlString: String) {
//        openExternalLink(urlString)
//    }
//
//    func openTermsOfUse(_ urlString: String) {
//        openExternalLink(urlString)
//    }
//
//    func openXapo(_ urlString: String) {
//        openExternalLink(urlString)
//    }
//    
//    func openExternalLink(_ urlString: String) {
//        guard let url = URL(string: urlString) else { return }
//        UIApplication.shared.open(url)
//    }
}
