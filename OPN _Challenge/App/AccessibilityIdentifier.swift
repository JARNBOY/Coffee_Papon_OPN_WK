//
//  AccessibilityIdentifier.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import Foundation
import SwiftUI

enum AccessibilityIdentifier: String {
    // Common
    case loadingProgress
    case errorLabel
    
    // Splash Screen
    case splashScreenImage
    case splashScreenGradient
    
    // Store Screen
    case storeDetailView
    case logoStoreImage
    case nameStoreLabel
    case timeOpenCloseStoreLabel
    case ratingLabel
    case productsListView
    case checkBoxView
    case productImage
    case productNameLabel
    case productPriceLabel
    case minusProductButton
    case productQTYLabel
    case plusProductButton
    case orderButton

    // Order Screen
    case productSelectedImage
    case productNameSelectedLabel
    case productPriceAndQTYSelectedLabel
    case totalPriceLabel
    case confirmButton
    
    var name: String {
        return rawValue.capitalized + "Identifier"
    }
}

struct AccessibilityModifier: ViewModifier {
    let identifier: AccessibilityIdentifier
    
    func body(content: Content) -> some View {
        content.accessibilityIdentifier(identifier.name)
    }
}

extension View {
    func accessibility(identifier: AccessibilityIdentifier) -> some View {
        self.modifier(AccessibilityModifier(identifier: identifier))
    }
}
