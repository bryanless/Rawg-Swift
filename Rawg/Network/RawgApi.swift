//
//  Const.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import Foundation
import Alamofire

struct RawgApi {
    private let BASE_URL = "https://api.rawg.io/api"
    private let GAMES = "games"
    private var API_KEY: String {
        // 1
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
            fatalError("Couldn't find file 'Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'Info.plist'.")
        }
        return value
    }

    enum Ordering: String {
        case name, released, added
        case created, updated, rating
        case metacritic
    }

    // MARK: - Get games
    func getGames(completion: @escaping (Result<[GamesResult], AFError>) -> Void) {
        AF.request("\(BASE_URL)/\(GAMES)", parameters: ["key": API_KEY])
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
        AF.request("\(BASE_URL)/\(GAMES)/\(id)", parameters: ["key": API_KEY])
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
