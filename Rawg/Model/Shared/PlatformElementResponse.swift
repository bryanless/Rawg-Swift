//
//  PlatformElementResponse.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import Foundation

// MARK: - PlatformElement
struct PlatformElement: Codable {
    let platform: PlatformPlatform
    let releasedAt: String?
    let requirements, requirementsEn, requirementsRu: Requirements?

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirements
        case requirementsEn = "requirements_en"
        case requirementsRu = "requirements_ru"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.platform = try container.decode(PlatformPlatform.self, forKey: .platform)
        self.releasedAt = try container.decodeIfPresent(String.self, forKey: .releasedAt)
        self.requirements = try container.decodeIfPresent(Requirements.self, forKey: .requirements)
        self.requirementsEn = try container.decodeIfPresent(Requirements.self, forKey: .requirementsEn)
        self.requirementsRu = try container.decodeIfPresent(Requirements.self, forKey: .requirementsRu)
    }
}

// MARK: - PlatformPlatform
struct PlatformPlatform: Codable {
    let id: Int
    let name, slug: String
    let image: String?
    let yearEnd, yearStart: Int?
    let gamesCount: Int?
    let imageBackground: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.slug = try container.decode(String.self, forKey: .slug)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.yearEnd = try container.decodeIfPresent(Int.self, forKey: .yearEnd)
        self.yearStart = try container.decodeIfPresent(Int.self, forKey: .yearStart)
        self.gamesCount = try? container.decode(Int.self, forKey: .gamesCount)
        self.imageBackground = try? container.decode(String.self, forKey: .imageBackground)
    }
}
