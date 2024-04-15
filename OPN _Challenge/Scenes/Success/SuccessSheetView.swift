//
//  SuccessSheetView.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import SwiftUI

struct SuccessSheetView: View {
    @State var timeRemaining = 4
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let onDismiss: (() -> Void)?
    
    var body: some View {
        VStack {
            
            Text("Successful orders Please wait for the ordered item for a moment.")
                .font(.system(size: 30))
            
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .foregroundColor(.green)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .padding()
            
            Button("Back to Order") {
                onDismiss?()
            }
            
            Text("Auto close Success order :\(timeRemaining)")
                .onReceive(timer) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else {
                        onDismiss?()
                    }
                }
        }
        .padding()
    }
}

//#Preview {
//    SuccessSheet()
//}
