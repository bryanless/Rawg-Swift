//
//  ExploreViewModel.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import Foundation

class ExploreViewModel: ObservableObject {
    @Published var currentState: ViewState = .start
    @Published var gameResult: [GamesResult] = []
    @Published var searchGameResult: [GamesResult] = []

    // MARK: - View state
    enum ViewState {
        case start, loading
        case success(_ games: [GamesResult])
        case failure(_ error: Error)
    }

    // MARK: - Fetch games
    func fetchGames() {
        self.currentState = .loading
        RawgApi().getGames { result in
            switch result {
            case let .success(games):
                self.gameResult = games
                self.currentState = .success(games)
            case let .failure(error):
                self.currentState = .failure(error)
            }
        }
    }

    // MARK: - Search games
    func searchGames(searchText: String) {
        // Return default game result if search text empty
        guard !searchText.isEmpty else {
            self.currentState = .success(self.gameResult)
            return
        }

        self.currentState = .loading
        RawgApi().searchGames(searchText: searchText) { result in
            switch result {
            case let .success(games):
                self.searchGameResult = games
                self.currentState = .success(games)
            case let .failure(error):
                self.currentState = .failure(error)
            }
        }
    }

    // MARK: - Initialize
    init() {
        fetchGames()
    }
}
