//
//  GamesResponse.swift
//  Rawg
//
//  Created by Bryan on 19/10/22.
//

import Foundation

// MARK: - GamesResponse
struct GamesResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [GamesResult]
    let seoTitle, seoDescription, seoKeywords, seoH1: String
    let noindex, nofollow: Bool
    let gamesResponseDescription: String
    let filters: Filters
    let nofollowCollections: [String]

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex, nofollow
        case gamesResponseDescription = "description"
        case filters
        case nofollowCollections = "nofollow_collections"
    }
}

// MARK: - Filters
struct Filters: Codable {
    let years: [FiltersYear]
}

// MARK: - FiltersYear
struct FiltersYear: Codable {
    let from, to: Int
    let filter: String
    let decade: Int
    let years: [YearYear]
    let nofollow: Bool
    let count: Int
}

// MARK: - YearYear
struct YearYear: Codable {
    let year, count: Int
    let nofollow: Bool
}

// MARK: - Result
struct GamesResult: Codable, Identifiable {
    let id: Int
    let slug, name, released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int
    let ratings: [Rating]
    let ratingsCount, reviewsTextCount, added: Int
    let addedByStatus: AddedByStatus
    let metacritic, playtime, suggestionsCount: Int
    let updated: String
    let userGame: String?
    let reviewsCount: Int
    let saturatedColor, dominantColor: Color
    let platforms: [PlatformElement]
    let parentPlatforms: [ParentPlatform]
    let genres: [Genre]
    let stores: [Store]
    let clip: String?
    let tags: [Genre]
    let esrbRating: EsrbRating?
    let shortScreenshots: [ShortScreenshot]

    enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case reviewsTextCount = "reviews_text_count"
        case added
        case addedByStatus = "added_by_status"
        case metacritic, playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case userGame = "user_game"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case platforms
        case parentPlatforms = "parent_platforms"
        case genres, stores, clip, tags
        case esrbRating = "esrb_rating"
        case shortScreenshots = "short_screenshots"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.slug = try container.decode(String.self, forKey: .slug)
        self.name = try container.decode(String.self, forKey: .name)
        let releasedString = try container.decode(String.self, forKey: .released)
        self.released = Formatter.formatDate(releasedString).description
        self.tba = try container.decode(Bool.self, forKey: .tba)
        self.backgroundImage = try container.decode(String.self, forKey: .backgroundImage)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.ratingTop = try container.decode(Int.self, forKey: .ratingTop)
        self.ratings = try container.decode([Rating].self, forKey: .ratings)
        self.ratingsCount = try container.decode(Int.self, forKey: .ratingsCount)
        self.reviewsTextCount = try container.decode(Int.self, forKey: .reviewsTextCount)
        self.added = try container.decode(Int.self, forKey: .added)
        self.addedByStatus = try container.decode(AddedByStatus.self, forKey: .addedByStatus)
        self.metacritic = try container.decode(Int.self, forKey: .metacritic)
        self.playtime = try container.decode(Int.self, forKey: .playtime)
        self.suggestionsCount = try container.decode(Int.self, forKey: .suggestionsCount)
        self.updated = try container.decode(String.self, forKey: .updated)
        self.userGame = try container.decodeIfPresent(String.self, forKey: .userGame)
        self.reviewsCount = try container.decode(Int.self, forKey: .reviewsCount)
        self.saturatedColor = try container.decode(Color.self, forKey: .saturatedColor)
        self.dominantColor = try container.decode(Color.self, forKey: .dominantColor)
        self.platforms = try container.decode([PlatformElement].self, forKey: .platforms)
        self.parentPlatforms = try container.decode([ParentPlatform].self, forKey: .parentPlatforms)
        self.genres = try container.decode([Genre].self, forKey: .genres)
        self.stores = try container.decode([Store].self, forKey: .stores)
        self.clip = try container.decodeIfPresent(String.self, forKey: .clip)
        self.tags = try container.decode([Genre].self, forKey: .tags)
        self.esrbRating = try container.decodeIfPresent(EsrbRating.self, forKey: .esrbRating)
        self.shortScreenshots = try container.decode([ShortScreenshot].self, forKey: .shortScreenshots)
    }
}

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
    let yet, owned, beaten, toplay: Int
    let dropped, playing: Int
}

enum Color: String, Codable {
    case the0F0F0F = "0f0f0f"
}

// MARK: - EsrbRating
struct EsrbRating: Codable {
    let id: Int
    let name, slug: String
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name, slug: String
    let gamesCount: Int
    let imageBackground: String
    let domain: Domain?
    let language: Language?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case domain, language
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

enum Language: String, Codable {
    case eng
}

// MARK: - ParentPlatform
struct ParentPlatform: Codable {
    let platform: EsrbRating
}

// MARK: - PlatformElement
struct PlatformElement: Codable {
    let platform: PlatformPlatform
    let releasedAt: String?
    let requirementsEn, requirementsRu: Requirements?

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirementsEn = "requirements_en"
        case requirementsRu = "requirements_ru"
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

// MARK: - Requirements
struct Requirements: Codable {
    let minimum: String
    let recommended: String?
}

// MARK: - Rating
struct Rating: Codable {
    let id: Int
    let title: Title
    let count: Int
    let percent: Double
}

enum Title: String, Codable {
    case exceptional, meh, recommended, skip
}

// MARK: - ShortScreenshot
struct ShortScreenshot: Codable {
    let id: Int
    let image: String
}

// MARK: - Store
struct Store: Codable {
    let id: Int
    let store: Genre
}
