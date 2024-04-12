//
//  OrderScreenView.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import SwiftUI

struct OrderScreenView: View {
    var coordinator: any AppCoordinatorProtocol
    
    var body: some View {
        Text("OrderScreenView")
    }
}

//{
//    @State private var deliveryAddress = ""
//    @State private var isLoading = false
//    @State private var isSuccessPresented = false
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            // Display selected products and total price
//            SelectedProductsView(products: selectedProducts)
//
//            // Delivery address input
//            DeliveryAddressView(address: $deliveryAddress)
//
//            Spacer()
//
//            // Place order button
//            PlaceOrderButton(isLoading: $isLoading) {
//                placeOrder()
//            }
//        }
//        .padding()
//        .sheet(isPresented: $isSuccessPresented) {
//            SuccessView { isSuccessPresented = false }
//        }
//    }
//
//    private func placeOrder() {
//        isLoading = true
//        // Make a POST request to the /order endpoint
//        // After the request is completed, show the Success screen
//        isSuccessPresented = true
//        isLoading = false
//    }
//}

//#Preview {
//    OrderScreenView()
//}
