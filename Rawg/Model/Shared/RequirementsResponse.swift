//
//  RequirementsResponse.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import Foundation

// MARK: - Requirements
struct Requirements: Codable {
    let minimum, recommended: String?
}
