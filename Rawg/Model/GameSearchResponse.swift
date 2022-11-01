//
//  GameSearchResponse.swift
//  Rawg
//
//  Created by Bryan on 23/10/22.
//

// MARK: - GameSearchResponse
struct GameSearchResponse: Codable {
    let count: Int
    let next, previous: String?
    let results: [GamesResult]
    let userPlatforms: Bool

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
        case userPlatforms = "user_platforms"
    }
}
