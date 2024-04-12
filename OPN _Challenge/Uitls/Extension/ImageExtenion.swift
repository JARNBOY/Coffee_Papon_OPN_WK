//
//  ImageExtenion.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import Foundation
import SwiftUI

enum ImageNames: String {
    // MARK: - Tabbar
    case coffeeLogo = "coffee_logo"
    
}

extension Image {
    /// Convenience initializer to create an `Image` instance from an `ImageNames` enumeration.
    init(with imageName: ImageNames) {
        self.init(imageName.rawValue, bundle: nil)
    }
}
