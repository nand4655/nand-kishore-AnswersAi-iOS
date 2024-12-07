//
//
// AppCardHeaderModel.swift
// AppStoreClone
//
// Created by Nand on 05/12/24
//
        
import SwiftUI

struct AppCardHeaderModel: Identifiable, Decodable {
    let id = UUID()
    let subheadline: String?
    let headline: String?
    let spotline: String?
    
    init(subheadline: String? = nil, headline: String? = nil, spotline: String? = nil) {
        self.subheadline = subheadline
        self.headline = headline
        self.spotline = spotline
    }
    
    enum CodingKeys: CodingKey {
        case subheadline
        case headline
        case spotline
    }
}
