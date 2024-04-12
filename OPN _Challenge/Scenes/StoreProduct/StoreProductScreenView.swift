//
//  StoreProductScreenView.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import SwiftUI

struct StoreProductScreenView: View {
    var coordinator: any AppCoordinatorProtocol
    
    var body: some View {
        Text("StoreProductScreenView")
    }
}

//{
//    @State private var selectedProducts: [Product] = []
//    @State private var isOrderSummaryPresented = false
//
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .leading) {
//                // Fetch and display store details
//                StoreDetailView(store: store)
//
//                // Fetch and display list of products
//                ProductListView(products: products, selectedProducts: $selectedProducts)
//
//                Spacer()
//
//                // Navigate to Order Summary screen
//                NavigationLink(destination: OrderSummaryView(selectedProducts: selectedProducts), isActive: $isOrderSummaryPresented) {
//                    OrderButton()
//                }
//            }
//            .padding()
//        }
//    }
//}

//#Preview {
//    StoreProductScreenView()
//}
