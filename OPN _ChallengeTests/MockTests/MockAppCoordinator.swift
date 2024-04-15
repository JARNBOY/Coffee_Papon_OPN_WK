//
//  MockAppCoordinator.swift
//  OPN _ChallengeTests
//
//  Created by Papon Supamongkonchai on 15/4/2567 BE.
//

import Foundation
@testable import OPN__Challenge

class MockAppCoordinator: AppCoordinatorProtocol {
    var pushScreenCalled = false
    var presentSheetCalled = false
    var fullScreenCalled = false
    var popCalled = false
    var popToRootCalled = false
    var dismissSheetCalled = false
    var fdismissFullScreenOverCalled = false
    
    func push(_ screen: Screen) {
        pushScreenCalled = true
    }
    
    func present(sheet: Sheet) {
        presentSheetCalled = true
    }
    
    func fullScreenOver(fullScreenOver: FullScreenOver) {
        fullScreenCalled = true
    }
    
    func pop() {
        popCalled = true
    }
    
    func popToRoot() {
        popToRootCalled = true
    }
    
    func dismissSheet() {
        dismissSheetCalled = true
    }
    
    func dismissFullScreenOver() {
        fdismissFullScreenOverCalled = true
    }
}
