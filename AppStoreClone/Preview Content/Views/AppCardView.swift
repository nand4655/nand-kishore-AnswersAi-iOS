//
//
// AppCardView.swift
// AppStoreClone
//
// Created by Nand on 07/12/24
//
        

import SwiftUI

enum AppCardStyle {
    case list
    case detail
}

struct AppCardView: View {
    let animation: Namespace.ID
    @State private var showBottomView = false
    @Binding var model: AppCardModel
    let style: AppCardStyle
    @Environment(\.dismiss) var dismiss
    @State private var showPurchaseSheet = false
    @State private var detentHeight: CGFloat = 0
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(\.imageCache) var cache: ImageCache
    
    var body: some View {
        switch style {
            case .list:
                VStack(alignment: .leading) {
                    AppCardHeaderView(model: $model.cardHeader)
                        .padding(.horizontal)
                    
                    imageView
                        .clipShape(RoundedRectangle(cornerRadius: Dimens.CornerRadius.unit16))
                        .shadow(radius: Dimens.CornerRadius.unit6)
                        .padding([.horizontal, .bottom], Dimens.unit16)
                }
                
            case .detail:
                ScrollView {
                    VStack(alignment: .leading) {
                        imageView
                        
                        VStack(alignment: .leading) {
                            Text(Texts.title)
                                .font(.t1)
                                .bold()
                            +
                            Text(Texts.content)
                                .font(.t1)
                                .foregroundStyle(.secondary)
                        }
                        .padding()
                        
                        HStack(spacing: Dimens.unit12) {
                            Rectangle()
                                .fill(CustomGradeints.g_green1)
                                .frame(height: Dimens.cardGradientHeight)
                                .clipShape(.rect(cornerRadius: Dimens.unit6))
                            
                            Rectangle()
                                .fill(CustomGradeints.g_blue1)
                                .frame(height: Dimens.cardGradientHeight)
                                .clipShape(.rect(cornerRadius: Dimens.unit6))
                        }
                        .padding(Dimens.unit16)
                        
                        Image("business")
                            .resizable()
                            .scaledToFill()
                            .frame(width: Dimens.w - Dimens.unit32, height: Dimens.sameImageHeight)
                            .clipped()
                            .padding(Dimens.unit16)
                        
                        VStack(alignment: .leading) {
                            Text(Texts.title2)
                                .font(.t1)
                                .italic()
                                .bold()
                            +
                            Text(Texts.content2)
                                .font(.t1)
                                .foregroundStyle(.secondary)
                        }
                        .padding(Dimens.unit16)
                        
                        ShareLink(item: "Hit the Ground Running with Runna") {
                            VStack {
                                HStack {
                                    Image(systemName: "square.and.arrow.up")
                                        .foregroundStyle(.white)
                                        .bold()
                                    
                                    Text("Share Story")
                                        .foregroundStyle(.white)
                                        .bold()
                                }
                                .padding(Dimens.unit16)
                            }
                            .background(.gray)
                            .clipShape(.rect(cornerRadius: Dimens.CornerRadius.unit6))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(Dimens.unit16)
                        .padding(.bottom, Dimens.unit24)
                    }
                }
                .onScrollGeometryChange(for: ScrollGeometry.self) { geo in
                    geo
                } action: { oldValue, newValue in
                    let conentHeight = abs(newValue.contentSize.height - newValue.containerSize.height)
                    let lowerLimit =  conentHeight * 0.1
                    let upperLimit = conentHeight * 0.95
                    
                    let shouldShow = abs(newValue.contentOffset.y) > lowerLimit && abs(newValue.contentOffset.y) < upperLimit
                    withAnimation {
                        showBottomView = shouldShow
                    }
                    
                }
                
                .overlay(alignment: .bottom) {
                    if showBottomView {
                        AppInfoView(appInfoModel: $model.appInfoModel, addMaterialBackground: true) { status in
                            if status != .installed {
                                showPurchaseSheet.toggle()
                            }
                        }
                        .ignoresSafeArea(.all, edges: [.bottom])
                        .clipShape(.rect(cornerRadius: Dimens.CornerRadius.unit28))
                        .transition(.move(edge: .bottom))
                        .offset(y: safeAreaInsets.bottom - Dimens.unit12)
                        .animation(.spring(bounce: 0.5))
                        .padding(Dimens.unit6)
                    }
                }
                .overlay {
                    ZStack(alignment: .topTrailing) {
                        closeButton
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    }
                }
                .overlay(alignment: .top) {
                    if showPurchaseSheet {
                        PurchaseAnimatingBackgroundView(showOverlay: $showPurchaseSheet)
                            .frame(maxWidth: Dimens.w)
                            .frame(maxHeight: Dimens.h + Dimens.purchaseOverlayOffset)
                    }
                    else { EmptyView()}
                }
                .sheet(isPresented: $showPurchaseSheet) {
                    PurchaseView(showSheet: $showPurchaseSheet, purchaseInfo: $model.appInfoModel)
                        .presentationDragIndicator(.visible)
                        .presentationDragIndicator(.visible)
                        .readHeight()
                        .onPreferenceChange(HeightPreferenceKey.self) { height in
                            if let height {
                                self.detentHeight = height
                            }
                        }
                        .presentationDetents([.height(self.detentHeight)])
                }
                .frame(maxHeight: .infinity)
                .scrollIndicators(.hidden)
                .ignoresSafeArea(.all, edges: [.top])
                .toolbar(.hidden)
                .statusBar(hidden: true)
        }
    }
    
    private var imageView: some View {
        ZStack(alignment: .bottom) {
            if let generateUrl = URL(string: model.image) {
                CachedAsyncImage(url: generateUrl, cache: cache, onImageDownload: { img in
                }, placeholder: {
                    ProgressView()
                        .tint(.black)
                        .frame(maxWidth: .infinity, maxHeight: Dimens.unit32)
                })
                .scaledToFill()
                .frame(width: style == .list ? Dimens.w - Dimens.unit32 :  Dimens.w, height: Dimens.cardDetailImageHeight)
                .clipped()
            }
            else {
                Rectangle()
                    .fill(.gray.opacity(0.5))
                    .frame(width: style == .list ? Dimens.w - Dimens.unit32 :  Dimens.w, height: Dimens.cardDetailImageHeight)
            }
            
            Rectangle()
                .fill(.thinMaterial)
                .frame(height: Dimens.cardGradientHeight / 2)
                .mask {
                    VStack(spacing: Dimens.unit0) {
                        CustomGradeints.linearWhite
                            .frame(height: Dimens.cardGradientFillHeight)
                        Rectangle()
                    }
                }
            
            ImageOverlayView(overlayModel: $model.appCardImageOverlayModel, appInfoModel: $model.appInfoModel) { _ in
                withAnimation {
                    showPurchaseSheet.toggle()
                }
            }
        }
    }
    
    private var closeButton: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "xmark")
                .fontWeight(.bold)
                .frame(width: Dimens.Size.unit20, height: Dimens.Size.unit20)
                .padding(Dimens.unit12)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
        .tint(.white)
        .padding([.horizontal, .top], Dimens.unit16)
    }
}

struct HeightPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat?
    
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        guard let nextValue = nextValue() else { return }
        value = nextValue
    }
}

#Preview("List Style") {
    @Previewable @State var viewModel = TodayViewModel()
    @Previewable @Namespace var hero
    ScrollView {
        AppCardView(animation: hero, model: .constant(TodayViewModel().cards[0]), style: .list)
    }
}

#Preview("Detail Style") {
    @Previewable @Namespace var hero
    NavigationStack {
        ScrollView {
            AppCardView(animation: hero, model: .constant(TodayViewModel().cards[0]), style: .detail)
        }
    }
}
