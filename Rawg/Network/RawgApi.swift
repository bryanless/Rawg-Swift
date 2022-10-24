//
//  Const.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import Foundation
import Alamofire

struct RawgApi {
    private let API_KEY = "56c20b91ae1648ac90d66da30067b299"
    private let BASE_URL = "https://api.rawg.io/api"
    private let GAMES = "games"

    private let defaultParameter = ["key": "56c20b91ae1648ac90d66da30067b299"]

    enum Ordering: String {
        case name, released, added
        case created, updated, rating
        case metacritic
    }

    // MARK: - Get games
    func getGames(completion: @escaping (Result<[GamesResult], AFError>) -> Void) {
        AF.request("\(BASE_URL)/\(GAMES)", parameters: defaultParameter)
            .validate()
            .responseDecodable(of: GamesResponse.self) { response in
                switch response.result {
                case let .success(data):
                    completion(.success(data.results))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }

    // MARK: - Get games ordered
    func getGamesOrdered(
        by ordering: Ordering,
        reversed: Bool = true,
        completion: @escaping (Result<[GamesResult], AFError>) -> Void
    ) {
        let orderingValue = reversed ? "-\(ordering.rawValue)" : ordering.rawValue

        AF.request("\(BASE_URL)/\(GAMES)", parameters: [
            "ordering": orderingValue,
            "key": API_KEY
        ])
        .validate()
        .responseDecodable(of: GamesResponse.self) { response in
            switch response.result {
            case let .success(data):
                completion(.success(data.results))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Get game details
    func getGame(id: String, completion: @escaping (Result<GameDetailResponse, AFError>) -> Void) {
        AF.request("\(BASE_URL)/\(GAMES)/\(id)", parameters: defaultParameter)
            .validate()
            .responseDecodable(of: GameDetailResponse.self) { response in
                switch response.result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
    }

    // MARK: - Search games
    func searchGames(searchText: String, completion: @escaping (Result<[GamesResult], AFError>) -> Void) {
        AF.request("\(BASE_URL)/\(GAMES)", parameters: [
            "search": searchText,
            "key": API_KEY
        ])
        .validate()
        .responseDecodable(of: GameSearchResponse.self) { response in
            switch response.result {
            case let .success(data):
                completion(.success(data.results))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
