//
//
// AppInfoView.swift
// AppStoreClone
//
// Created by Nand on 07/12/24
//


import Foundation
import SwiftUI

struct ImageOverlayView: View {
    @Binding var overlayModel: AppCardImageOverlayModel?
    @Binding var appInfoModel: AppPurchaseInfoModel?
    var actionButtonClick: ((AppInstallStatus) -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: Dimens.unit6) {
            if let subheadline = overlayModel?.subheadline {
                Text(subheadline)
                    .font(.s1)
                    .bold()
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(.horizontal, Dimens.unit16)
            }
            
            if let headline = overlayModel?.headline {
                Text(headline)
                    .font(.l1)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                    .bold()
                    .padding(.horizontal)
            }
            
            if let spotline = overlayModel?.spotline {
                Text(spotline)
                    .font(.s2)
                    .foregroundStyle(.white.opacity(0.7))
                    .lineLimit(1)
                    .padding([.horizontal], Dimens.unit16)
            }
            
            Color.clear
                .frame(height: Dimens.unit6)
            
            AppInfoView(appInfoModel: $appInfoModel, addMaterialBackground: true) { status in
                actionButtonClick?(status)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}


#Preview("ImageOverlayView") {
    ImageOverlayView(overlayModel: .constant(AppCardImageOverlayModel(subheadline: "COLLECTION", headline: "Word games for your inner intellectual", spotline: "Arrange a special collection")), appInfoModel: .constant(AppPurchaseInfoModel(installStatus: .notInstalled, image: "", appName: "Solitaire", productLine: "NK V \nAPP", userEmail: "abc.abc.abc", publisher: "NK V"))
        )
}
