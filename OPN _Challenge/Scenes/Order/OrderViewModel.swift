//
//  OrderViewModel.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 15/4/2567 BE.
//

import Foundation

final class OrderViewModel: ObservableObject {
    
    private let service: CoffeeAPIService
    
    init(service: CoffeeAPIService) {
        self.service = service
    }
    
}
