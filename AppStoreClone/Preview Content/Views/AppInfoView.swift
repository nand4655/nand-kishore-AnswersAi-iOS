//
//
// AppInfoView.swift
// AppStoreClone
//
// Created by Nand on 07/12/24
//


import Foundation
import SwiftUI

struct AppInfoView: View {
    @Binding var appInfoModel: AppPurchaseInfoModel?
    let addMaterialBackground: Bool
    var actionButtonClick: ((AppInstallStatus) -> Void)?
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View {
        if let appInfoModel {
            VStack {
                HStack() {                    
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
                            .foregroundStyle(Color(.white))
                            .multilineTextAlignment(.leading)
                        
                        Text(appInfoModel.productLine ?? "")
                            .font(.s1)
                            .foregroundStyle(.white.opacity(0.7))
                            .multilineTextAlignment(.leading)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .center) {
                        Button(action: {
                            actionButtonClick?(appInfoModel.installStatus)
                        }) {
                            Text(appInfoModel.installStatus == .installed ? String(localized: "open") : String(localized: "get"))
                                .font(.s1h)
                                .foregroundStyle(.white)
                                .padding(.horizontal, Dimens.unit24)
                        }
                        .frame(height: Dimens.Size.unit32)
                        .background(.gray.opacity(0.3))
                        .clipShape(.rect(cornerRadius: Dimens.CornerRadius.unit16))
                        .padding(.top, Dimens.unit16)
                        
                        if appInfoModel.installStatus == .notInstalled {
                            Text(String(localized: "inAppPurchases"))
                                .font(.s4)
                                .foregroundStyle(.white.opacity(0.9))
                        }
                    }
                }
                .padding(Dimens.unit12)
            }
            .background(.ultraThinMaterial)
        }
    }
}

#Preview("AppInfoView") {
    NavigationStack {
        AppInfoView(appInfoModel: .constant(AppPurchaseInfoModel(installStatus: .notInstalled, image: "", appName: "Solitaire", productLine: "NK V \nAPP", userEmail: "abc.abc.abc", publisher: "NK V")), addMaterialBackground: true
        )
    }
}
