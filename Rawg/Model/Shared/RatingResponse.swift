//
//  RatingResponse.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import Foundation

// MARK: - Rating
struct Rating: Codable {
    let id: Int
    let title: Title?
    let count: Int?
    let percent: Double?
}

enum Title: String, Codable {
    case exceptional, meh, recommended, skip
}
