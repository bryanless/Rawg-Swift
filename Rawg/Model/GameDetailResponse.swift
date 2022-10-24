//
//  GameDetailResponse.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import Foundation

// MARK: - GameDetailResponse
struct GameDetailResponse: Codable {
    let id: Int
    let slug, name, nameOriginal, gameDetailResponseDescription: String
    let metacritic: Int?
    let metacriticPlatforms: [MetacriticPlatform]?
    let released: String?
    let tba: Bool?
    let updated: String?
    let backgroundImage, backgroundImageAdditional: String?
    let website: String?
    let rating: Double
    let ratingTop: Int?
    let ratings: [Rating]?
    let reactions: [String: Int]?
    let added: Int?
    let addedByStatus: AddedByStatus?
    let playtime, screenshotsCount, moviesCount, creatorsCount: Int?
    let achievementsCount, parentAchievementsCount: Int?
    let redditURL: String?
    let redditName, redditDescription, redditLogo: String?
    let redditCount, twitchCount, youtubeCount, reviewsTextCount: Int?
    let ratingsCount: Int
    let suggestionsCount: Int?
    let alternativeNames: [String]?
    let metacriticURL: String?
    let parentsCount, additionsCount, gameSeriesCount: Int?
    let userGame: String?
    let reviewsCount: Int?
    let saturatedColor, dominantColor: String?
    let parentPlatforms: [ParentPlatform]?
    let platforms: [PlatformElement]?
    let stores: [Store]?
    let developers, genres: [Genre]
    let tags: [Genre]?
    let publishers: [Genre]
    let esrbRating: EsrbRating?
    let clip: String?
    let descriptionRaw: String

    enum CodingKeys: String, CodingKey {
        case id, slug, name
        case nameOriginal = "name_original"
        case gameDetailResponseDescription = "description"
        case metacritic
        case metacriticPlatforms = "metacritic_platforms"
        case released, tba, updated
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website, rating
        case ratingTop = "rating_top"
        case ratings, reactions, added
        case addedByStatus = "added_by_status"
        case playtime
        case screenshotsCount = "screenshots_count"
        case moviesCount = "movies_count"
        case creatorsCount = "creators_count"
        case achievementsCount = "achievements_count"
        case parentAchievementsCount = "parent_achievements_count"
        case redditURL = "reddit_url"
        case redditName = "reddit_name"
        case redditDescription = "reddit_description"
        case redditLogo = "reddit_logo"
        case redditCount = "reddit_count"
        case twitchCount = "twitch_count"
        case youtubeCount = "youtube_count"
        case reviewsTextCount = "reviews_text_count"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
        case alternativeNames = "alternative_names"
        case metacriticURL = "metacritic_url"
        case parentsCount = "parents_count"
        case additionsCount = "additions_count"
        case gameSeriesCount = "game_series_count"
        case userGame = "user_game"
        case reviewsCount = "reviews_count"
        case saturatedColor = "saturated_color"
        case dominantColor = "dominant_color"
        case parentPlatforms = "parent_platforms"
        case platforms, stores, developers, genres, tags, publishers
        case esrbRating = "esrb_rating"
        case clip
        case descriptionRaw = "description_raw"
    }

    // swiftlint:disable function_body_length
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.slug = try container.decode(String.self, forKey: .slug)
        self.name = try container.decode(String.self, forKey: .name)
        self.nameOriginal = try container.decode(String.self, forKey: .nameOriginal)
        self.gameDetailResponseDescription = try container.decode(String.self, forKey: .gameDetailResponseDescription)
        self.metacritic = try? container.decode(Int.self, forKey: .metacritic)
        self.metacriticPlatforms = try? container.decode([MetacriticPlatform].self, forKey: .metacriticPlatforms)
        let releasedString = try? container.decode(String.self, forKey: .released)
        self.released = Formatter.toFullDate(releasedString ?? "-")
        self.tba = try? container.decode(Bool.self, forKey: .tba)
        self.updated = try? container.decode(String.self, forKey: .updated)
        self.backgroundImage = try? container.decode(String.self, forKey: .backgroundImage)
        self.backgroundImageAdditional = try? container.decode(String.self, forKey: .backgroundImageAdditional)
        self.website = try? container.decode(String.self, forKey: .website)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.ratingTop = try? container.decode(Int.self, forKey: .ratingTop)
        self.ratings = try? container.decode([Rating].self, forKey: .ratings)
        self.reactions = try? container.decode([String: Int].self, forKey: .reactions)
        self.added = try? container.decode(Int.self, forKey: .added)
        self.addedByStatus = try? container.decode(AddedByStatus.self, forKey: .addedByStatus)
        self.playtime = try? container.decode(Int.self, forKey: .playtime)
        self.screenshotsCount = try? container.decode(Int.self, forKey: .screenshotsCount)
        self.moviesCount = try? container.decode(Int.self, forKey: .moviesCount)
        self.creatorsCount = try? container.decode(Int.self, forKey: .creatorsCount)
        self.achievementsCount = try? container.decode(Int.self, forKey: .achievementsCount)
        self.parentAchievementsCount = try? container.decode(Int.self, forKey: .parentAchievementsCount)
        self.redditURL = try? container.decode(String.self, forKey: .redditURL)
        self.redditName = try? container.decode(String.self, forKey: .redditName)
        self.redditDescription = try? container.decode(String.self, forKey: .redditDescription)
        self.redditLogo = try? container.decode(String.self, forKey: .redditLogo)
        self.redditCount = try? container.decode(Int.self, forKey: .redditCount)
        self.twitchCount = try? container.decode(Int.self, forKey: .twitchCount)
        self.youtubeCount = try? container.decode(Int.self, forKey: .youtubeCount)
        self.reviewsTextCount = try? container.decode(Int.self, forKey: .reviewsTextCount)
        self.ratingsCount = try container.decode(Int.self, forKey: .ratingsCount)
        self.suggestionsCount = try? container.decode(Int.self, forKey: .suggestionsCount)
        self.alternativeNames = try? container.decode([String].self, forKey: .alternativeNames)
        self.metacriticURL = try? container.decode(String.self, forKey: .metacriticURL)
        self.parentsCount = try? container.decode(Int.self, forKey: .parentsCount)
        self.additionsCount = try? container.decode(Int.self, forKey: .additionsCount)
        self.gameSeriesCount = try? container.decode(Int.self, forKey: .gameSeriesCount)
        self.userGame = try? container.decodeIfPresent(String.self, forKey: .userGame)
        self.reviewsCount = try? container.decode(Int.self, forKey: .reviewsCount)
        self.saturatedColor = try? container.decode(String.self, forKey: .saturatedColor)
        self.dominantColor = try? container.decode(String.self, forKey: .dominantColor)
        self.parentPlatforms = try? container.decode([ParentPlatform].self, forKey: .parentPlatforms)
        self.platforms = try? container.decode([PlatformElement].self, forKey: .platforms)
        self.stores = try? container.decode([Store].self, forKey: .stores)
        self.developers = try container.decode([Genre].self, forKey: .developers)
        self.genres = try container.decode([Genre].self, forKey: .genres)
        self.tags = try? container.decode([Genre].self, forKey: .tags)
        self.publishers = try container.decode([Genre].self, forKey: .publishers)
        self.esrbRating = try? container.decode(EsrbRating.self, forKey: .esrbRating)
        self.clip = try container.decodeIfPresent(String.self, forKey: .clip)
        self.descriptionRaw = try container.decode(String.self, forKey: .descriptionRaw)
    }
}

// MARK: - MetacriticPlatform
struct MetacriticPlatform: Codable {
    let metascore: Int?
    let url: String?
    let platform: MetacriticPlatformPlatform?
}

// MARK: - MetacriticPlatformPlatform
struct MetacriticPlatformPlatform: Codable {
    let platform: Int?
    let name, slug: String?
}
