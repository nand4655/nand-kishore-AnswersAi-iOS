//
//
// DismissableView.swift
// AppStoreClone
//
// Created by Nand on 07/12/24
//
        

import SwiftUI

struct DismissableView<Content: View>: View {
    @Environment(\.dismiss) private var dismiss
    private var content: () -> Content
    @State var scaleFactor: CGFloat = 1
    @State var cornerRadius: CGFloat = 16
    @State var opacity: CGFloat = 1
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var dismissButton: some View {
        HStack {
            Spacer()
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color(uiColor: .label))
                    .background(Color(uiColor: .systemBackground))
                    .clipShape(Circle())
            }
            .padding([.top, .trailing], 30)
        }
    }
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                content()
                dismissButton
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()
        .background(Color(UIColor.secondarySystemBackground))
        .scrollIndicators(scaleFactor < 1 ? .hidden : .automatic, axes: .vertical)
        .onScrollGeometryChange(for: CGFloat.self) { geometry in
            geometry.contentOffset.y
        } action: { oldValue, newValue in
            if newValue >= 0 {
                scaleFactor = 1
                cornerRadius = 16
                opacity = 1
            }
            else {
                scaleFactor = 1 - (0.1 * (newValue / -50))
                cornerRadius = 55 - (35 / 50 * -newValue)
                opacity = 1 - (abs(newValue) / 50)
            }
        }
        .onScrollGeometryChange(for: Bool.self) { geometry in
            geometry.contentOffset.y < -50
        } action: { _, isTornOff in
            if isTornOff {
                dismiss()
            }
        }
    }
}
