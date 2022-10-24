//
//  ParentPlatformResponse.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import Foundation

// MARK: - ParentPlatform
struct ParentPlatform: Codable {
    let platform: EsrbRating
}

// MARK: - EsrbRating
struct EsrbRating: Codable {
    let id: Int
    let name: EsrbRatingName
    let slug: EsrbRatingSlug
    let nameEn, nameRu: String?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        let nameString = try container.decode(String.self, forKey: .name)
        self.name = EsrbRatingName(rawValue: nameString) ?? EsrbRatingName.everyone
        let slugString = try container.decode(String.self, forKey: .slug)
        self.slug = EsrbRatingSlug(rawValue: slugString) ?? EsrbRatingSlug.everyone
        self.nameEn = try? container.decodeIfPresent(String.self, forKey: .nameEn)
        self.nameRu = try? container.decodeIfPresent(String.self, forKey: .nameRu)
    }
}

enum EsrbRatingName: String, Codable {
    case everyone = "Everyone"
    case everyoneTenPlus = "Everyone 10+"
    case teen = "Teen"
    case mature = "Mature"
    case adultsOnly = "Adults Only"
    case ratingPending = "Rating Pending"
}

enum EsrbRatingSlug: String, Codable {
    case everyone
    case everyoneTenPlus = "everyone-10-plus"
    case teen, mature
    case adultsOnly = "adults-only"
    case ratingPending = "rating-pending"
}

enum EsrbRatingAge: String, Codable {
    case everyone = "0+"
    case everyoneTenPlus = "10+"
    case teen = "13+"
    case mature = "17+"
    case adultsOnly = "18+"
    case ratingPending = "-"
}

extension EsrbRatingSlug {
    func toAge() -> EsrbRatingAge {
        switch self {
        case .everyone:
            return EsrbRatingAge.everyone
        case .everyoneTenPlus:
            return EsrbRatingAge.everyoneTenPlus
        case .teen:
            return EsrbRatingAge.teen
        case .mature:
            return EsrbRatingAge.mature
        case .adultsOnly:
            return EsrbRatingAge.adultsOnly
        case .ratingPending:
            return EsrbRatingAge.ratingPending
        }
    }
}
