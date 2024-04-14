//
//  CoordinatorView.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 14/4/2567 BE.
//

import SwiftUI

struct CoordinatorView: View {
    
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) { 
            coordinator.build(screen: .splash)
                .navigationDestination(for: Screen.self) { screen in
                    coordinator.build(screen: screen)
                }
                .sheet(item: $coordinator.sheet) { sheet in
                    coordinator.build(sheet: sheet)
                }
                .fullScreenCover(item: $coordinator.fullScreenOver) { fullScreenOver in
                    coordinator.build(fullScreenOver: fullScreenOver)
                }
        }
        .environmentObject(coordinator)
    }
}
