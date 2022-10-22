//
//  StoreResponse.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import Foundation

// MARK: - Store
struct Store: Codable {
    let id: Int
    let url: String?
    let store: Developer

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.store = try container.decode(Developer.self, forKey: .store)
    }
}
