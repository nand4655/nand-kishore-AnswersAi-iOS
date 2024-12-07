//
//
// PurchaseView.swift
// AppStoreClone
//
// Created by Nand on 07/12/24
//


import SwiftUI

struct PurchaseView: View {
    @Binding var showSheet: Bool
    @Binding var purchaseInfo: AppPurchaseInfoModel?
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("App Store")
                        .font(.t1)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: {
                        showSheet.toggle()
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .resizable()
                            .foregroundStyle(.gray.opacity(0.5))
                            .frame(width: Dimens.Size.unit24, height: Dimens.Size.unit24)            
                            .clipShape(Circle())
                    }
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        if let url = purchaseInfo?.image, let generateUrl = URL(string: url) {
                            CachedAsyncImage(url: generateUrl, cache: cache, onImageDownload: { img in
                            }, placeholder: {
                                ProgressView()
                                    .tint(.black)
                                    .frame(maxWidth: .infinity, maxHeight: Dimens.Size.unit32)
                            })
                            .clipShape(.rect(cornerRadius: Dimens.CornerRadius.unit12))
                            .frame(width: Dimens.Size.unit56, height: Dimens.Size.unit56)
                        }
                        else {
                            Rectangle()
                                .fill(.gray.opacity(0.5))
                                .frame(width: Dimens.Size.unit56, height: Dimens.Size.unit56)
                        }
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 2) {
                                Text(purchaseInfo?.appName ?? "")
                                    .font(.s1)

                                
                                Image(systemName: "17.square")
                            }
                            
                            if let productLine = purchaseInfo?.productLine {
                                Text(productLine)
                                    .font(.s3)
                                    .foregroundStyle(.black.opacity(0.7))
                                    .lineLimit(2)
                            }
                            
                            if let publisher = purchaseInfo?.publisher {
                                Text(publisher)
                                    .font(.s3)
                                    .foregroundStyle(.black.opacity(0.7))
                                    .lineLimit(2)
                            }
                        }
                    }
                    
                    Divider()
                        .padding(.top, Dimens.unit6)
                    
                    if let userEmail = purchaseInfo?.userEmail {
                        Text("Account: \(userEmail)")
                            .font(.s3)
                            .foregroundStyle(.black.opacity(0.7))
                            .padding(.top, Dimens.unit6)
                    }
                }
                .padding()
                .background(.white.opacity(0.9))
                .clipShape(.rect(cornerRadius: Dimens.CornerRadius.unit12))
                
                Image(systemName: "button.vertical.right.press")
                    .resizable()
                    .foregroundStyle(.blue.opacity(0.5))
                    .frame(width: Dimens.Size.unit40, height:Dimens.Size.unit40)
                    .padding(.top, Dimens.unit12)
                
                Text("Confirm with Side Button")
                    .font(.s2)
                    .padding(.top, Dimens.unit6)
            }
            .padding()
        }
        .background(.gray.opacity(0.15))
        .frame(maxWidth: .infinity, alignment: .bottom)
        
    }
}

#Preview("Purchase") {
    NavigationStack {
        PurchaseView(showSheet: .constant(true), purchaseInfo: .constant(AppPurchaseInfoModel(installStatus: .notInstalled, image: "https://cdn.dribbble.com/userupload/10867807/file/original-0ab84e6336e44d251490a9f534d1103b.png?resize=752x&vertical=center", appName: "Solitaire", productLine: "APP", userEmail: "abc.abc.abc", publisher: "NKV")))
            //.background(.orange.opacity(0.7))
    }
}
