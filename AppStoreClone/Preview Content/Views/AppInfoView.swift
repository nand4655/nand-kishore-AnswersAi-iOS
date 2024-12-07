//
//
// AppInfoView.swift
// AppStoreClone
//
// Created by Nand on 07/12/24
//


import Foundation
import SwiftUI

enum AppInfoViewStyle {
    case dark
    case light
}

struct AppInfoView: View {
    let style: AppInfoViewStyle
    @Binding var appInfoModel: AppPurchaseInfoModel?
    let addMaterialBackground: Bool
    var actionButtonClick: ((AppInstallStatus) -> Void)?
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View {
        if let appInfoModel {
            VStack {
                HStack(alignment: .center) {
                    if let generateUrl = URL(string: appInfoModel.image) {
                        CachedAsyncImage(url: generateUrl, cache: cache, onImageDownload: { img in
                        }, placeholder: {
                            ProgressView()
                                .tint(.black)
                                .frame(maxWidth: .infinity, maxHeight: 335)
                        })
                        .scaledToFill()
                        .frame(width: Dimens.Size.unit40, height: Dimens.Size.unit40)
                        .clipShape(.rect(cornerRadius: Dimens.CornerRadius.unit12))
                        .clipped()
                    }
                    else {
                        Rectangle()
                            .fill(.gray.opacity(0.5))
                            .scaledToFill()
                            .frame(width: Dimens.Size.unit40, height: Dimens.Size.unit40)
                            .clipShape(.rect(cornerRadius: Dimens.CornerRadius.unit12))
                            .clipped()
                    }
                    
                    VStack(alignment: .leading) {
                        Text(appInfoModel.appName ?? "")
                            .font(.s1)
                            .bold()
                            .foregroundStyle(style == .dark ? .black : .white)
                            .multilineTextAlignment(.leading)
                        
                        Text(appInfoModel.productLine ?? "")
                            .font(.s2)
                            .foregroundStyle(style == .dark ? .black.opacity(0.6) : .white.opacity(0.7))
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .center) {
                        Button(action: {
                            actionButtonClick?(appInfoModel.installStatus)
                        }) {
                            Text(appInfoModel.installStatus == .installed ? String(localized: "open") : String(localized: "get"))
                                .font(.s1h)
                                .foregroundStyle(style == .dark ? .blue.opacity(0.9) : .white)
                                .padding(.horizontal, Dimens.unit24)
                        }
                        .frame(height: Dimens.Size.unit32)
                        .background(.gray.opacity(0.3))
                        .clipShape(.rect(cornerRadius: Dimens.CornerRadius.unit16))
                
                        
                        if appInfoModel.installStatus == .notInstalled {
                            Text(String(localized: "inAppPurchases"))
                                .font(.s4)
                                .foregroundStyle(style == .dark ? .black.opacity(0.6) : .white.opacity(0.9))
                        }
                    }
                }
                .padding(.horizontal, Dimens.unit12)
                .padding(.vertical, Dimens.unit6)
            }
            .background(.ultraThinMaterial)
        }
    }
}

#Preview("AppInfoView") {
    NavigationStack {
        AppInfoView(style: .dark, appInfoModel: .constant(AppPurchaseInfoModel(installStatus: .notInstalled, image: "", appName: "Solitaire", productLine: "NK V \nAPP", userEmail: "abc.abc.abc", publisher: "NK V")), addMaterialBackground: true
        )
    }
}
