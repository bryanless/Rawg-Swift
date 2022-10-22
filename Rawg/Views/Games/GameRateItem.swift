//
//  GameRateItem.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import SwiftUI

struct GameRateItem<Content: View>: View {
    @State var label: String
    @State var title: String
    @ViewBuilder var text: Content

    var body: some View {
        VStack(
            spacing: Space.tiny
        ) {
            Text(label)
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            Text(title)
                .font(.title3)
                .fontWeight(.bold)
            text
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

struct GameRateItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GameRateItem(label: "10 RATINGS", title: "3.6", text: { RatingView(rating: 3.6) })
                .previewDisplayName("Rating")

            GameRateItem(label: "AGE", title: "12+", text: { Text("Years Old") })
                .previewDisplayName("Age")
        }
    }
}
