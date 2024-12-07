//
//
// CachedAsyncImage.swift
// AppStoreClone
//
// Created by Nand on 07/12/24
//
        
import SwiftUI

struct CachedAsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder
    var onImageDownload: ((UIImage) -> Void)?
    
    init(url: URL, cache: ImageCache?, onImageDownload: ((UIImage) -> Void)? = nil, @ViewBuilder placeholder: () -> Placeholder) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: cache))
        self.placeholder = placeholder()
        self.onImageDownload = onImageDownload
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    @ViewBuilder
    private var content: some View {
        if let image = loader.image {
            Image(uiImage: image)
                .resizable()
                .onAppear {
                    onImageDownload?(image)
                }
        } else {
            placeholder
        }
    }
}

