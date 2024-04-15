//
//  OrderScreenView.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import SwiftUI

struct OrderScreenView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    @ObservedObject private var viewModel: OrderViewModel
    
    init(viewModel: OrderViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            // List Order
            ScrollView {
                ForEach(viewModel.selectedProduct, id: \.self) { product in
                    HStack {
                        // Image
                        AsyncImage(url: URL(string: product.info.imageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 80, height: 80)
                        } placeholder: {
                            ProgressView()
                        }
                        .accessibility(identifier: .productSelectedImage)
                        
                        Text("\(product.info.name)")
                            .accessibility(identifier: .productNameSelectedLabel)
                        
                        Spacer()
                        
                        Text("\(product.info.price.toDecimal()) x \(product.qty)")
                            .accessibility(identifier: .productPriceAndQTYSelectedLabel)
                    }
                    .padding()
                }
            }
            .padding()
            
            totalPriceView()
            
            confirmButtonBottom()
                .accessibility(identifier: .confirmButton)
        }
        .overlay {
            if viewModel.stateUI == .loading {
                ProgressView()
            }
        }
        
    }
    
    @ViewBuilder
    private func totalPriceView() -> some View {
        HStack(alignment: .bottom) {
            Spacer()
            
            Text("Total: ")
                .font(.system(size: 20))
                .fontWeight(.heavy)
            
            Text("\(viewModel.totalPrice.toDecimal())")
                .font(.system(size: 30))
                .fontWeight(.heavy)
                .accessibility(identifier: .totalPriceLabel)
            
        }
        .padding()
    }
    
    @ViewBuilder
    private func confirmButtonBottom() -> some View {
        HStack {
            BaseButton(title: "Confirm") {
                viewModel.requestMakeOrder(coordinator: coordinator)
            }
        }
        .frame(width: .infinity,height: 100)
        .background( .white )
    }
}

//#Preview {
//    OrderScreenView()
//}
