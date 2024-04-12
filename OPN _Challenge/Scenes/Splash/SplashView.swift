//
//  SplashView.swift
//  OPN _Challenge
//
//  Created by Papon Supamongkonchai on 12/4/2567 BE.
//

import SwiftUI

struct SplashView: View {
    @State private var animatedGradient = true
    @State private var logoOpacity: Double = 1
    
    var coordinator: any AppCoordinatorProtocol
    
    var body: some View {
        ZStack {
            backgroundGradient
            logoImage
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.0).delay(0.5)) {
                logoOpacity = 0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                coordinator.showStoreProductScreen()
            }
        }
    }
    
    private var logoImage: some View {
        Image(with: .coffeeLogo)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 90, height: 90)
            .foregroundColor(.orange)
            .opacity(logoOpacity)
            .accessibility(identifier: .splashScreenImage)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 4)
                    .frame(width: 120, height: 120)
                    .opacity(logoOpacity)
            )
    }
    
    private var backgroundGradient: some View {
        LinearGradient(colors: [Color(colorName:.splashBackground), .brown, Color(colorName:.splashBackground)],
                       startPoint: .topLeading, endPoint: .bottomTrailing)
        .hueRotation(.degrees(animatedGradient ? 45 : 0))
        .ignoresSafeArea()
        .accessibility(identifier: .splashScreenGradient)
        .onAppear {
            withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                animatedGradient.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                coordinator.showStoreProductScreen()
            }
        }
    }
}

//#Preview {
//    SplashView()
//}
