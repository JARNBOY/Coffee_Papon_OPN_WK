//
//  SuccessSheetView.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import SwiftUI

struct SuccessSheetView: View {
    var coordinator: any AppCoordinatorProtocol
    @State var timeRemaining = 4
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let onDismiss: (() -> Void)?
    
    var body: some View {
        
        Button("Back to Order") {
            onDismiss?()
        }
        
        Text("Auto close :\(timeRemaining)")
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    onDismiss?()
                }
            }
    }
}

//#Preview {
//    SuccessSheet()
//}
