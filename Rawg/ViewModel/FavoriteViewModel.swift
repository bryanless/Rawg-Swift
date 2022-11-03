//
//  FavoriteViewModel.swift
//  Rawg
//
//  Created by Bryan on 01/11/22.
//

import Foundation

class FavoriteViewModel: ObservableObject {
    @Published var currentState: ViewState = .start
    @Published var favoriteGames: [FavoriteModel] = []

    // MARK: - View state
    enum ViewState {
        case start, loading
        case success
        case failure(_ error: Error)
    }

    // MARK: - Get all favorite games
    func getFavorites() {
        self.currentState = .loading
        UserProvider().getFavorites { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(favorites):
                    self.favoriteGames = favorites
                    self.currentState = .success
                case let .failure(error):
                    self.currentState = .failure(error)
                }
            }
        }
    }

    init() {
        getFavorites()
    }
}
