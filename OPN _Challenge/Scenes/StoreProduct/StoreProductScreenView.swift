//
//  StoreProductScreenView.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import SwiftUI

struct StoreProductScreenView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    @StateObject private var viewModel: StoreProductViewModel
    
    init(viewModel: StoreProductViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            switch viewModel.stateUI {
            case .loading:
                Spacer()
                ProgressView()
                    .accessibility(identifier: .loadingProgress)
                Spacer()
            case .success:
                ScrollView {
                    if let storeData = viewModel.displayStore?.storeInfo {
                        StoreDetailView(store: storeData)
                            .accessibility(identifier: .storeDetailView)
                    }
                    if let productsData = viewModel.displayStore?.productsInfo {
                        ProductListView(products: productsData, storeProductViewModel: viewModel)
                            .frame(width: .infinity)
                            .padding()
                            .accessibility(identifier: .productsListView)
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
                    .accessibility(identifier: .errorLabel)
                Spacer()
            case .idle:
                EmptyView()
            }
            
            // Navigate to Order screen
            BaseButton(title: "Order") {
                viewModel.openOrderScreen(coordinator: coordinator)
            }
            .disabled(viewModel.isDisableOrderButton)
            .accessibility(identifier: .orderButton)
            
        }
        .background( .black )
        .edgesIgnoringSafeArea(.top)
        .onAppear(perform: {
            viewModel.feedAllStoreAPI()
        })
        .navigationBarBackButtonHidden()
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
                .accessibility(identifier: .logoStoreImage)
            
            VStack(alignment: .leading) {
                Text(store.name)
                    .font(.title2)
                    .accessibility(identifier: .nameStoreLabel)
                
                Text("Open: \(store.openingTime) - Close: \(store.closingTime)")
                    .accessibility(identifier: .timeOpenCloseStoreLabel)
                
                Text("Rating: \(store.rating.oneDecimalPlace)")
                    .accessibility(identifier: .ratingLabel)
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
                    .accessibility(identifier: .productImage)
                    
                    // Detail Product
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .accentColor(.white)
                            .accessibility(identifier: .productNameLabel)
                        Text("Price: \(product.price.toString) Bath")
                            .accentColor(.white)
                            .accessibility(identifier: .productPriceLabel)
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
                    .accessibility(identifier: .minusProductButton)
                    
                    Text("\(String(describing: storeProductViewModel.selectedProduct[product]?.qty ?? 0))")
                        .accessibility(identifier: .productQTYLabel)
                    
                    Button(action: {
                        storeProductViewModel.incrementSelectedProduct(for: product)
                    }, label: {
                        Image(systemName: "plus.circle")
                            .tint(Color.green)
                            .frame(width: 40, height: 40)
                    })
                    .accessibility(identifier: .plusProductButton)
                    
                }
                .frame(width: .infinity, height: 150)
            }
            .toggleStyle(iOSCheckboxToggleStyle())
            .accessibility(identifier: .checkBoxView)
            
        }
    }
}
