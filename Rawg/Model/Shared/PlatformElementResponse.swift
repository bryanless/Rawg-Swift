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

    init(platform: PlatformPlatform,
         releasedAt: String?,
         requirements: Requirements?,
         requirementsEn: Requirements?,
         requirementsRu: Requirements?) {
        self.platform = platform
        self.releasedAt = releasedAt
        self.requirements = requirements
        self.requirementsEn = requirementsEn
        self.requirementsRu = requirementsRu
    }
}

// MARK: - PlatformPlatform
struct PlatformPlatform: Codable {
    let id: Int
    let name, slug: String
    let image: String?
    let yearEnd, yearStart: Int?
    let gamesCount: Int
    let imageBackground: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
