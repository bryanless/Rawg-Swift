//
//  GenreResponse.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int?
    let imageBackground: String?
    let domain: String?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
    }
}
