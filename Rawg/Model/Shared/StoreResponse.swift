//
//  StoreResponse.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import Foundation

// MARK: - Store
struct Store: Codable {
    let id: Int?
    let url: String?
    let store: Genre?
}
