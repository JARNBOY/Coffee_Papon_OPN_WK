//
//  StoreProductScreenView.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import SwiftUI

struct StoreProductScreenView: View {
    var coordinator: any AppCoordinatorProtocol
    
    @State private var selectedProducts: [ProductInfo] = []
//    @State private var isOrderSummaryPresented = false

    var body: some View {
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
////                NavigationLink(destination: OrderSummaryView(selectedProducts: selectedProducts), isActive: $isOrderSummaryPresented) {
////                    OrderButton()
////                }
//            }
//            .padding()
//        }
        VStack {
            ScrollView {
                // TODO: Mock before call API real
                if let moclData = resultMockToStoreInfoRequestStatusSuccess() {
                    // Fetch and display store details
                    StoreDetailView(store: moclData)
                }
                
                // Fetch and display list of products
                
                // Navigate to Order Summary screen
                Text("3000000")
                Spacer()
                    .frame(height: 1200)
            }
            
        }
        .edgesIgnoringSafeArea(.top)
    }
    
   
}

//#Preview {
//    StoreProductScreenView()
//}

struct StoreDetailView: View {
    
    @State var store: StoreInfo
    
    var body: some View {
        ZStack {
            backgroundGradient
            detailStore
                .offset(y: 30)
        }
        .frame(width: .infinity, height: 360)
    }
    
    private var detailStore: some View {
        VStack {
            Image(with: .coffeeLogo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 90, height: 90)
                .foregroundColor(.orange)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 4)
                        .frame(width: 120, height: 120)
                )
                .padding()
            
            VStack(alignment: .leading) {
                Text(store.name)
                    .font(.title2)
                Text("Open: \(store.openingTime) - Close: \(store.closingTime)")
                Text("Rating: \(store.rating.oneDecimalPlace)")
            }
            
        }
        
        
    }
    
    private var backgroundGradient: some View {
        LinearGradient(colors: [Color(colorName:.splashBackground), .brown, Color(colorName:.splashBackground)],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct ProductListView: View {
    var body: some View {
        ZStack {}
    }
}
