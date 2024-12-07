//
//
// Today.swift
// AppStoreClone
//
// Created by Nand on 05/12/24
//

import SwiftUI

struct TodayView: View {
    @StateObject var viewModel = TodayViewModel()
    @Namespace private var hero
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                TodayHeaderView()
                
                ForEach($viewModel.cards, id: \.id) { card in
                    NavigationLink {
                        AppCardView(animation: hero, model: card, style: .detail)
                            .navigationTransition(.zoom(sourceID: card.id, in: hero))
                    } label: {
                        AppCardView(animation: hero, model: card, style: .list)
                    }
                    .matchedTransitionSource(id: card.id, in: hero)
                    .buttonStyle(.plain)
                }
            }
        }
        .scrollIndicators(.hidden)
        .onAppear {
            viewModel.getCards()
        }
    }
}

#Preview {
    TodayView()
}


