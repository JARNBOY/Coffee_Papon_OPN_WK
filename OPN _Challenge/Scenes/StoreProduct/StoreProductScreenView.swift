//
//  StoreProductScreenView.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import SwiftUI

struct StoreProductScreenView: View {
    @StateObject private var viewModel: StoreProductViewModel
    @State private var isOrderSummaryPresented = false
    
    init(viewModel: StoreProductViewModel, isOrderSummaryPresented: Bool = false) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.isOrderSummaryPresented = isOrderSummaryPresented
    }
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.stateUI {
                case .loading:
                    Spacer()
                    ProgressView()
                    Spacer()
                case .success:
                    ScrollView {
                        if let storeData = viewModel.displayStore?.storeInfo {
                            StoreDetailView(store: storeData)
                        }
                        if let productsData = viewModel.displayStore?.productsInfo {
                            ProductListView(products: productsData, storeProductViewModel: viewModel)
                                .frame(width: .infinity)
                                .padding()
                        }
                    }
                    
                case .error:
                    Spacer()
                    Text(viewModel.errorMessage ?? "")
                        .font(.system(.subheadline, design: .rounded))
                        .fontWeight(.heavy)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .accentColor(Color.blue)
                    Spacer()
                case .idle:
                    EmptyView()
                }
                
                // Navigate to Order screen
                NavigationLink(destination: viewModel.openOrderScreen(), isActive: $isOrderSummaryPresented) {
                    // Order Button
                    Button(action: {
                        isOrderSummaryPresented.toggle()
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
                
            }
            .background( .black )
            .edgesIgnoringSafeArea(.top)
            .onAppear(perform: {
                viewModel.feedAllStoreAPI()
            })
        }
        
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
    @StateObject var storeProductViewModel: StoreProductViewModel
    
    var body: some View {
        ForEach(products, id: \.self) { product in
            Toggle(isOn: Binding(
                get: {
                    storeProductViewModel.selectedProduct[product]?.isSelected ?? false
                },
                set: { isSelected in
                    if var orderInfo = storeProductViewModel.selectedProduct[product] {
                        orderInfo.isSelected = isSelected
                        orderInfo.qty = isSelected ? 1 : 0
                        storeProductViewModel.selectedProduct[product] = orderInfo
                    }
                }
            )) {
                HStack(spacing: 8) {
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
                            .accentColor(.white)
                        Text("Price: \(product.price.toString) Bath")
                            .accentColor(.white)
                    }
                    .padding()
                    
                    // Button +, - and Number
                    Button(action: {
                        storeProductViewModel.decrementSelectedProduct(for: product)
                    }, label: {
                        Image(systemName: "minus.circle")
                            .tint(Color.red)
                            .frame(width: 40, height: 40)
                    })
                    
                    Text("\(String(describing: storeProductViewModel.selectedProduct[product]?.qty ?? 0))")
                    
                    Button(action: {
                        storeProductViewModel.incrementSelectedProduct(for: product)
                    }, label: {
                        Image(systemName: "plus.circle")
                            .tint(Color.green)
                            .frame(width: 40, height: 40)
                    })
                    
                }
                .frame(width: .infinity, height: 150)
            }
            .toggleStyle(iOSCheckboxToggleStyle())
            
            
        }
    }
}
