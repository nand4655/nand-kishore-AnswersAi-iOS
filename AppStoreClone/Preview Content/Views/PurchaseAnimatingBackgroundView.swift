//
//
// PurchaseAnimatingBackgroundView.swift
// AppStoreClone
//
// Created by Nand on 07/12/24
//
        

import SwiftUI

struct PurchaseAnimatingBackgroundView: View {
    @State private var offsetX: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var timer: Timer?
    @Binding var showOverlay: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
            
            HStack() {
                Spacer()
                Text("Double-Click\nto install")
                    .font(.t2)
                    .foregroundStyle(.white)
                    .offset(y: -155)
                    .multilineTextAlignment(.trailing)
                
                Color.white
                    .frame(width: 6, height: 90)
                    .clipShape(RoundedCorners(tl: 3, tr: 3, bl: 3, br: 3))
                    .offset(y: -144)
                
            }
            .offset(x: offsetX)
            .animation(.spring(bounce: 0.9), value: offsetX)
            .onAppear {
                offsetX = 0
                isAnimating = true
                
                startTimer()
            }
            .onDisappear {
                stopTimer()
            }
        }
        
        .ignoresSafeArea()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
            isAnimating = true
            offsetX = offsetX == 0 ? -5 : 0
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

#Preview("PurchaseAnimatingBackgroundView") {
    NavigationStack {
        PurchaseAnimatingBackgroundView(showOverlay: .constant(true))
    }
}
