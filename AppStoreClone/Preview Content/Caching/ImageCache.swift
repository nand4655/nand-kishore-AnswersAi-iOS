//
//
// ImageCache.swift
// AppStoreClone
//
// Created by Nand on 07/12/24
//
        

import Foundation
import SwiftUI
import Combine
import UIKit
import CommonCrypto

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

class TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set {
            if let newValue = newValue {
                cache.setObject(newValue, forKey: key as NSURL)
                saveImageToFilesystem(url: key, image: newValue)
            } else {
                cache.removeObject(forKey: key as NSURL)
                removeImageFromFilesystem(url: key)
            }
        }
    }
    
    private func saveImageToFilesystem(url: URL, image: UIImage) {
        guard let data = image.pngData() else { return }
        let fileURL = getFileURL(for: url)
        do {
            try data.write(to: fileURL)
        } catch {
            print("Error saving image to filesystem: \(error)")
        }
    }
    
    private func removeImageFromFilesystem(url: URL) {
        let fileURL = getFileURL(for: url)
        try? FileManager.default.removeItem(at: fileURL)
    }
    
    func getImageFromFilesystem(url: URL) -> UIImage? {
        let fileURL = getFileURL(for: url)
        guard let data = try? Data(contentsOf: fileURL) else { return nil }
        return UIImage(data: data)
    }
    
    private func getFileURL(for url: URL) -> URL {
        let urlString = url.absoluteString
        let fileName = sha256(urlString)
        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
        return fileURL
    }
    
    private func sha256(_ input: String) -> String {
        guard let data = input.data(using: .utf8) else { return "" }
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    private var cache: ImageCache?
    private var cancellable: AnyCancellable?
    
    init(url: URL, cache: ImageCache?) {
        self.url = url
        self.cache = cache
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func load() {
        if let image = cache?[url] {
            self.image = image
            return
        } else if let image = (cache as? TemporaryImageCache)?.getImageFromFilesystem(url: url) {
            self.image = image
            cache?[url] = image
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: { [weak self] in self?.cache($0) })
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    private func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0 }
    }
}

