//
//  GameItem.swift
//  Rawg
//
//  Created by Bryan on 19/10/22.
//

import SwiftUI

struct GameItem: View {
    @State var game: GamesResult

    var body: some View {
        VStack(
            alignment: .leading,
            spacing: Space.small
        ) {
            KFImageView(game.backgroundImage)
            VStack(
                alignment: .leading,
                spacing: Space.tiny
            ) {
                Text(game.name)
                    .font(.headline)
                    .lineLimit(2, reservesSpace: true)
                Text(game.released)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            HStack(
                spacing: 4.0
            ) {
                Image(systemName: Icons.star)
                    .foregroundColor(.yellow)
                Text(game.rating.description)
                    .font(.footnote)
            }
        }
        .cornerRadius(Shape.roundedCorner)
    }
}

struct GameItem_Previews: PreviewProvider {
    static let gamesResponse: GamesResponse = PreviewData.load(file: "games_response")

    static var previews: some View {
        GameItem(game: gamesResponse.results.first!)
    }
}
