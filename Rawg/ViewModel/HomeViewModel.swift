//
//  HomeViewModel.swift
//  Rawg
//
//  Created by Bryan on 24/10/22.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var currentRecentlyUpdatedState: ViewState = .start
    @Published var currentTopRatedState: ViewState = .start
    @Published var currentLatestReleasedState: ViewState = .start

    // MARK: - View state
    enum ViewState {
        case start, loading
        case success(_ games: [GamesResult])
        case failure(_ error: Error)
    }

    // MARK: - Fetch recently updated games
    func fetchRecentlyUpdatedGames() {
        self.currentRecentlyUpdatedState = .loading
        RawgApi().getGamesOrdered(by: .updated) { result in
            switch result {
            case let .success(games):
                self.currentRecentlyUpdatedState = .success(games)
            case let .failure(error):
                self.currentRecentlyUpdatedState = .failure(error)
            }
        }
    }

    // MARK: - Fetch top rated games
    func fetchTopRatedGames() {
        self.currentTopRatedState = .loading
        RawgApi().getGamesOrdered(by: .rating) { result in
            switch result {
            case let .success(games):
                self.currentTopRatedState = .success(games)
            case let .failure(error):
                self.currentTopRatedState = .failure(error)
            }
        }
    }

    // MARK: - Fetch latest released games
    func fetchLatestReleasedGames() {
        self.currentLatestReleasedState = .loading
        RawgApi().getGamesOrdered(by: .released) { result in
            switch result {
            case let .success(games):
                self.currentLatestReleasedState = .success(games)
            case let .failure(error):
                self.currentLatestReleasedState = .failure(error)
            }
        }
    }

    // MARK: - Initialize
    init() {
        fetchRecentlyUpdatedGames()
        fetchTopRatedGames()
        fetchLatestReleasedGames()
    }
}
