//
//
// ReadHeightModifier.swift
// AppStoreClone
//
// Created by Nand on 07/12/24
//
        

import SwiftUI

private struct ReadHeightModifier: ViewModifier {
    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: HeightPreferenceKey.self,
                                   value: geometry.size.height)
        }
    }
    
    func body(content: Content) -> some View {
        content.background(sizeView)
    }
}

extension View {
    func readHeight() -> some View {
        self.modifier(ReadHeightModifier())
    }
}
