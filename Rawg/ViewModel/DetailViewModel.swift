//
//  DetailViewModel.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var currentState: ViewState = .start
    @Published var isFavorite: Bool = false

    // MARK: - View state
    enum ViewState {
        case start, loading
        case success(_ games: GameDetailResponse)
        case failure(_ error: Error)
    }

    // MARK: - Fetch game details
    func fetchGame(_ id: String) {
        self.currentState = .loading
        RawgApi().getGame(id: id) { result in
            switch result {
            case let .success(games):
                self.currentState = .success(games)
            case let .failure(error):
                self.currentState = .failure(error)
            }
        }
    }

    // MARK: - Get favorite game by ID
    func getFavoriteById(_ id: String) {
        UserProvider().getFavoriteById(id) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(favorite):
                    self.isFavorite = favorite.isFavorite ?? false
                case let .failure(error):
                    self.currentState = .failure(error)
                }
            }
        }
    }

    // MARK: - Initialize
    init(id: String) {
        fetchGame(id)
        getFavoriteById(id)
    }
}
