//
//  OrderScreenView.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import SwiftUI

struct OrderScreenView: View {
    var coordinator: any AppCoordinatorProtocol
    var selectedProduct: [StoreProductModel.OrderInfo] = []
    var totalPrice: Double {
        var totalP = 0.0
        for order in selectedProduct {
            totalP += order.info.price * Double(order.qty)
        }
        return totalP
    }
    
    var body: some View {
        VStack {
            Text("OrderScreenView")
            ForEach(selectedProduct, id: \.self) { product in
                HStack {
                    Text("\(product.info.name)")
                    Spacer()
                    Text("\(product.info.price) x \(product.qty)")
                }
            }
            HStack {
                Spacer()
                
                Text("total: \(totalPrice)")
            }
            Spacer()
            Button(action: {
                print("Go to Success screen")
            }, label: {
                Text("Confirm")
            })
        }
        
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
