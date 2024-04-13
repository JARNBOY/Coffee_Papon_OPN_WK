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
        VStack {
            ScrollView {
                // TODO: Mock before call API real
                if let mockStoreData = resultMockToStoreInfoRequestStatusSuccess() {
                    // Fetch and display store details
                    StoreDetailView(store: mockStoreData)
                }
                
                // TODO: Mock before call API real
                if let mockProductsData = resultMockJSONResponseProductInfosRequestStatusSuccess() {
                    // Fetch and display list of products
                    ProductListView(products: mockProductsData)
                        .frame(width: .infinity)
                }
            }
            
            // Button open Order Screen
            Button(action: {
                print("open Order Screen")
            }, label: {
                HStack {
                    Spacer()
                    
                    Text("Order".uppercased())
                      .font(.system(.subheadline, design: .rounded))
                      .fontWeight(.heavy)
                      .padding(.horizontal, 20)
                      .padding(.vertical, 12)
                      .accentColor(Color.pink)
                    
                    Spacer()
                }
                .background(
                  Capsule().stroke(Color.pink, lineWidth: 2)
                )
                .padding()
            })
            .frame(height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
    
    @State var products: [ProductInfo]
    @State var selectedProduct: [ProductInfo: Int] = [:]
    
    var body: some View {
        ForEach(products, id: \.self) { product in
            LazyHStack(spacing: 8) {
                // Image
                AsyncImage(url: URL(string: product.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 150)
                } placeholder: {
                    ProgressView()
                }
                
                // Detail Product
                VStack(alignment: .leading) {
                    Text(product.name)
                    Text("Price: \(product.price.toString) Bath")
                }
                
                Spacer()
                
                // Button +, - and Number
                Button(action: {
                    decrementSelectedProduct(for: product)
                }, label: {
                    Image(systemName: "minus.circle")
                        .tint(Color.red)
                        .frame(width: 40, height: 40)
                })
                
                Text("\(String(describing: selectedProduct[product] ?? 0))")
                
                Button(action: {
                    incrementSelectedProduct(for: product)
                }, label: {
                    Image(systemName: "plus.circle")
                        .tint(Color.green)
                        .frame(width: 40, height: 40)
                })
                
            }
            .frame(height: 150)
        }
        .onAppear(perform: {
            initializeSelectedProduct()
        })
    }
    
    private func initializeSelectedProduct() {
            selectedProduct = products.map { product in
                return (product, 0)
            }.reduce(into: [:]) { result, element in
                result[element.0] = element.1
            }
        }

        private func incrementSelectedProduct(for product: ProductInfo) {
            if var count = selectedProduct[product] {
                count += 1
                selectedProduct[product] = count
            }
        }

        private func decrementSelectedProduct(for product: ProductInfo) {
            if var count = selectedProduct[product], count > 0 {
                count -= 1
                selectedProduct[product] = count
            }
        }
    
}
