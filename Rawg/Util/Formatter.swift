//
//  Formatter2.swift
//  Rawg
//
//  Created by Bryan on 21/10/22.
//

import Foundation

struct Formatter {
    static func formatDate(_ dateString: String) -> String {
        let dateFormatterApi = DateFormatter()
        let dateFormatterReleased = DateFormatter()

        dateFormatterApi.dateFormat = "yyyy-MM-dd"
        dateFormatterReleased.dateFormat = "MMM dd, yyyy"

        guard let date = dateFormatterApi.date(from: dateString) else {
            return dateString
        }

        let released = dateFormatterReleased.string(from: date)

        return released
    }
}
