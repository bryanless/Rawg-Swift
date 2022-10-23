//
//  GenreResponse.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import Foundation

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int?
    let imageBackground: String?
    let domain: Domain?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.slug = try container.decode(String.self, forKey: .slug)
        self.gamesCount = try? container.decode(Int.self, forKey: .gamesCount)
        self.imageBackground = try? container.decode(String.self, forKey: .imageBackground)
        self.domain = try? container.decodeIfPresent(Domain.self, forKey: .domain)
        self.language = try? container.decodeIfPresent(String.self, forKey: .language)
    }
}

enum Domain: String, Codable {
    case appsAppleCOM = "apps.apple.com"
    case epicgamesCOM = "epicgames.com"
    case gogCOM = "gog.com"
    case marketplaceXboxCOM = "marketplace.xbox.com"
    case microsoftCOM = "microsoft.com"
    case nintendoCOM = "nintendo.com"
    case playGoogleCOM = "play.google.com"
    case storePlaystationCOM = "store.playstation.com"
    case storeSteampoweredCOM = "store.steampowered.com"
}
