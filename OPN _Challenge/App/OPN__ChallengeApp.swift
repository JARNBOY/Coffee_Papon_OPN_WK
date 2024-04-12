//
//  OPN__ChallengeApp.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import SwiftUI

@main
struct OPN__ChallengeApp: App {
    @StateObject var coordinator: AppCoordinator

    init() {
        let viewFactory = DefaultViewFactory()
        _coordinator = StateObject(wrappedValue: AppCoordinator(viewFactory: viewFactory))
    }

    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}


