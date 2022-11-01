//
//  GameDetailResponse.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

// MARK: - GameDetailResponse
struct GameDetailResponse: Codable {
    let id: Int
    let name: String
    let metacritic: Int?
    let released: String?
    let backgroundImage: String?
    let rating: Double
    let ratingsCount: Int
    let developers, genres, publishers: [Genre]
    let esrbRating: EsrbRating?
    let descriptionRaw: String

    enum CodingKeys: String, CodingKey {
        case id, name, metacritic
        case released
        case backgroundImage = "background_image"
        case rating
        case ratingsCount = "ratings_count"
        case developers, genres, publishers
        case esrbRating = "esrb_rating"
        case descriptionRaw = "description_raw"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.metacritic = try? container.decode(Int.self, forKey: .metacritic)
        let releasedString = try? container.decode(String.self, forKey: .released)
        self.released = Formatter.toFullDate(releasedString ?? "-")
        self.backgroundImage = try? container.decode(String.self, forKey: .backgroundImage)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.ratingsCount = try container.decode(Int.self, forKey: .ratingsCount)
        self.developers = try container.decode([Genre].self, forKey: .developers)
        self.genres = try container.decode([Genre].self, forKey: .genres)
        self.publishers = try container.decode([Genre].self, forKey: .publishers)
        self.esrbRating = try? container.decode(EsrbRating.self, forKey: .esrbRating)
        self.descriptionRaw = try container.decode(String.self, forKey: .descriptionRaw)
    }
}
