//
//  AddedByStatusResponse.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

// MARK: - AddedByStatus
struct AddedByStatus: Codable {
    let yet, owned, beaten, toplay: Int?
    let dropped, playing: Int?
}
