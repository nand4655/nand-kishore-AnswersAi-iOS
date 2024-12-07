//
//
// TodayViewModel.swift
// AppStoreClone
//
// Created by Nand on 04/12/24
//


import SwiftUI

class TodayViewModel: ObservableObject {
    @Published var cards: [AppCardModel] = []
    let apiService: APIClientExecutable
    
    init( apiService: APIClientExecutable = APIService()) {
        self.apiService = apiService
    }
    
    func getCards() {
        Task.detached { [weak self] in
            guard let self = self else { return }
            let request = TodayGetAPIRequest()
            let result: APIResult<[AppCardModel], APIClientError> = await self.apiService.execute(request)
            switch result {
                case .success(let res):
                    await self.updateCards(with: res)
                case .failure(let e):
                    print(e)
            }
        }
    }
    
    @MainActor
    func updateCards(with cards: [AppCardModel]) {
        self.cards = cards
    }
}
