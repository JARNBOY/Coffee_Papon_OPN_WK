//
//  BaseButton.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 14/4/2567 BE.
//

import SwiftUI

struct BaseButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Spacer()
                
                Text(title.uppercased())
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
    }
}

//#Preview {
//    BaseButton()
//}
