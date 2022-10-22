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

    private let defaultParameter = ["key": "56c20b91ae1648ac90d66da30067b299"]

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
}
