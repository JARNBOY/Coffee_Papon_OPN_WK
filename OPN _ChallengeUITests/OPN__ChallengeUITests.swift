//
//  OPN__ChallengeUITests.swift
//  OPN _ChallengeUITests
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import XCTest

final class OPN__ChallengeUITests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-UITests"]
        app.launch()
    }
    
    func testLaunchScreen() {
        // Wait for the splash screen to appear
         let imageLogoSplashScreen = app.images[AccessibilityIdentifier.splashScreenImage.name]
         XCTAssert(imageLogoSplashScreen.waitForExistence(timeout: 0.5))

         // Assert that the image is displayed correctly
         XCTAssertTrue(imageLogoSplashScreen.exists)
    }

    func testFullRegressionAppOPNChallenge() {
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.switches["Dark Tiramisu Mocha, Price: 75 Bath, 0"].buttons[AccessibilityIdentifier.plusProductButton.name].tap()
        elementsQuery.switches["Dark Tiramisu Mocha, Price: 75 Bath, 1"].buttons[AccessibilityIdentifier.plusProductButton.name].tap()
        elementsQuery.switches["Dark Tiramisu Mocha, Price: 75 Bath, 2"].buttons[AccessibilityIdentifier.plusProductButton.name].tap()
        elementsQuery.switches["Latte, Price: 50 Bath, 0"].buttons[AccessibilityIdentifier.plusProductButton.name].tap()
        elementsQuery.switches["Latte, Price: 50 Bath, 1"].buttons[AccessibilityIdentifier.plusProductButton.name].tap()
        app.buttons[AccessibilityIdentifier.orderButton.name].tap()
        app.buttons[AccessibilityIdentifier.confirmButton.name].tap()
        app.buttons["Back to Order"].tap()
        
    }
}
