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
            alignment: .leading
        ) {
            gameItemImage(game.backgroundImage ?? "")
            VStack(
                alignment: .leading,
                spacing: Space.small
            ) {
                VStack(
                    alignment: .leading,
                    spacing: Space.tiny
                ) {
                    Text(game.name)
                        .font(.body)
                        .lineLimit(2, reservesSpace: true)
                    Text(game.released ?? "-")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                HStack(
                    spacing: Space.tiny
                ) {
                    Image(systemName: Icons.star)
                        .font(.system(size: 12))
                        .foregroundColor(.yellow)
                    Text(game.rating.description)
                        .font(.footnote)
                }
            }
            .padding([.leading, .trailing, .bottom], Space.small)
        }
        .background(Color.surfaceColor)
        .cornerRadius(Shape.roundedCorner)
    }
}

struct GameItem_Previews: PreviewProvider {
    static let gamesResponse: GamesResponse = PreviewData.load("games_response")

    static var previews: some View {
        GameItem(game: gamesResponse.results.first!)
    }
}
