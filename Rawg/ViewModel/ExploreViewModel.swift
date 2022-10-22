//
//  ExploreViewModel.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import Foundation
import Alamofire

class ExploreViewModel: ObservableObject {
    @Published var currentState: ViewState = .start

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
