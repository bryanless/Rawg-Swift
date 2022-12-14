//
//  GameResultResponse.swift
//  Rawg
//
//  Created by Bryan on 23/10/22.
//

// MARK: - Result
struct GamesResult: Codable, Identifiable {
    let id: Int
    let slug, name: String
    let released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double
    let ratingTop: Int?
    let ratings: [Rating]?
    let ratingsCount: Int
    let reviewsTextCount, added: Int?
    let addedByStatus: AddedByStatus?
    let metacritic: Int?
    let playtime, suggestionsCount: Int?
    let updated: String?
    let userGame: String?
    let reviewsCount: Int?
    let saturatedColor, dominantColor: String?
    let platforms: [PlatformElement]?
    let parentPlatforms: [ParentPlatform]?
    let genres: [Genre]?
    let stores: [Store]?
    let clip: String?
    let tags: [Genre]?
    let esrbRating: EsrbRating?
    let shortScreenshots: [ShortScreenshot]?
    let score: String?
    let communityRating: Int?

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
        case score
        case communityRating = "community_rating"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.slug = try container.decode(String.self, forKey: .slug)
        self.name = try container.decode(String.self, forKey: .name)
        let releasedString = try? container.decode(String.self, forKey: .released)
        self.released = Formatter.toShortDate(releasedString ?? "-").description
        self.tba = try? container.decode(Bool.self, forKey: .tba)
        self.backgroundImage = try? container.decode(String.self, forKey: .backgroundImage)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.ratingTop = try? container.decode(Int.self, forKey: .ratingTop)
        self.ratings = try? container.decode([Rating].self, forKey: .ratings)
        self.ratingsCount = try container.decode(Int.self, forKey: .ratingsCount)
        self.reviewsTextCount = try? container.decode(Int.self, forKey: .reviewsTextCount)
        self.added = try? container.decode(Int.self, forKey: .added)
        self.addedByStatus = try? container.decode(AddedByStatus.self, forKey: .addedByStatus)
        self.metacritic = try? container.decode(Int.self, forKey: .metacritic)
        self.playtime = try? container.decode(Int.self, forKey: .playtime)
        self.suggestionsCount = try? container.decode(Int.self, forKey: .suggestionsCount)
        self.updated = try? container.decode(String.self, forKey: .updated)
        self.userGame = try? container.decodeIfPresent(String.self, forKey: .userGame)
        self.reviewsCount = try? container.decode(Int.self, forKey: .reviewsCount)
        self.saturatedColor = try? container.decode(String.self, forKey: .saturatedColor)
        self.dominantColor = try? container.decode(String.self, forKey: .dominantColor)
        self.platforms = try? container.decode([PlatformElement].self, forKey: .platforms)
        self.parentPlatforms = try? container.decode([ParentPlatform].self, forKey: .parentPlatforms)
        self.genres = try? container.decode([Genre].self, forKey: .genres)
        self.stores = try? container.decode([Store].self, forKey: .stores)
        self.clip = try? container.decodeIfPresent(String.self, forKey: .clip)
        self.tags = try? container.decode([Genre].self, forKey: .tags)
        self.esrbRating = try? container.decodeIfPresent(EsrbRating.self, forKey: .esrbRating)
        self.shortScreenshots = try? container.decode([ShortScreenshot].self, forKey: .shortScreenshots)
        self.score = try? container.decode(String.self, forKey: .score)
        self.communityRating = try? container.decode(Int.self, forKey: .communityRating)
    }
}
