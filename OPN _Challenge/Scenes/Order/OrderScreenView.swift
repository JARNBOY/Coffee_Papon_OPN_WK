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
            // List Order
            ScrollView {
                ForEach(selectedProduct, id: \.self) { product in
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
                        
                        Text("\(product.info.name)")
                        
                        Spacer()
                        
                        Text("\(product.info.price.toDecimal()) x \(product.qty)")
                    }
                    .padding()
                }
            }
            .padding()
            
            totalPriceView()
            
            confirmButtonBottom()
        }
        
    }
    
    @ViewBuilder
    private func totalPriceView() -> some View {
        HStack(alignment: .bottom) {
            Spacer()
            
            Text("Total: ")
                .font(.system(size: 20))
                .fontWeight(.heavy)
            
            Text("\(totalPrice.toDecimal())")
                .font(.system(size: 30))
                .fontWeight(.heavy)
            
        }
        .padding()
    }
    
    @ViewBuilder
    private func confirmButtonBottom() -> some View {
        HStack {
            BaseButton(title: "Confirm") {
                print("Go to Success screen")
            }
        }
        .frame(width: .infinity,height: 100)
        .background( .white )
    }
}

//#Preview {
//    OrderScreenView()
//}
