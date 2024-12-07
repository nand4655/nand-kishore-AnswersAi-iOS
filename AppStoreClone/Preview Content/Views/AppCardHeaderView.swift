//
//
// AppCardHeaderView.swift
// AppStoreClone
//
// Created by Nand on 07/12/24
//
        

import Foundation
import SwiftUI

struct AppCardHeaderView: View {
    @Binding var model: AppCardHeaderModel?
    
    var body: some View {
        if let model {
            VStack(alignment: .leading, spacing: Dimens.unit6) {
                if let subheadline = model.subheadline {
                    Text(subheadline)
                        .font(.s1)
                        .bold()
                        .foregroundStyle(.black.opacity(0.5))
                }
                
                if let headline = model.headline {
                    Text(headline)
                        .font(.h1)
                        .bold()
                        .foregroundStyle(Color(.black))
                        .lineLimit(2)
                }
                
                if let spotline = model.spotline {
                    Text(spotline)
                        .font(.s1)
                        .bold()
                        .foregroundStyle(.black.opacity(0.5))
                }
            }
        }
    }
}

#Preview("AppCardHeaderView") {
    NavigationStack {
        AppCardHeaderView(model:
                .constant(AppCardHeaderModel(
                    subheadline: "OUR FAVOURITES",
                    headline: "Watch the Abu Dhabi Grand Prix",
                    spotline: "Now Trending"))
        )
    }
}
