//
//
// AppCardModel.swift
// AppStoreClone
//
// Created by Nand on 05/12/24
//
        
import SwiftUI

enum AppCardType: String, Decodable {
    case plain
    case sponsored
    case groupedApps
}

struct AppCardModel: Identifiable, Hashable, Decodable {
    let id = UUID()
    let cardType: AppCardType
    var cardHeader: AppCardHeaderModel?
    let image: String
    var appCardImageOverlayModel: AppCardImageOverlayModel?
    var appInfoModel: AppPurchaseInfoModel?
    
    init(cardType: AppCardType, cardHeader: AppCardHeaderModel? = nil, image: String, appCardImageOverlayModel: AppCardImageOverlayModel? = nil, appInfoModel: AppPurchaseInfoModel? = nil) {
        self.cardType = cardType
        self.cardHeader = cardHeader
        self.image = image
        self.appCardImageOverlayModel = appCardImageOverlayModel
        self.appInfoModel = appInfoModel
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cardType = try container.decode(AppCardType.self,
                                        forKey: .cardType)
        image = try container.decode(String.self, forKey: .image)
        cardHeader = try? container.decodeIfPresent(AppCardHeaderModel.self, forKey: .cardHeader)
        appCardImageOverlayModel = try? container.decodeIfPresent(AppCardImageOverlayModel.self, forKey: .appCardImageOverlayModel)
        appInfoModel = try? container.decodeIfPresent(AppPurchaseInfoModel.self, forKey: .appInfoModel)
    }
    
    enum CodingKeys: CodingKey {
        case cardType
        case cardHeader
        case image
        case appCardImageOverlayModel
        case appInfoModel
    }
    
    static func == (lhs: AppCardModel, rhs: AppCardModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
