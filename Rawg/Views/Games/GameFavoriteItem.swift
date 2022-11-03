//
//  GameFavoriteItem.swift
//  Rawg
//
//  Created by Bryan on 04/11/22.
//

import SwiftUI

struct GameFavoriteItem: View {
    @State var game: FavoriteModel

    var body: some View {
        VStack(
            alignment: .leading
        ) {
            if game.backgroundImage == nil {
                gameItemImagePlaceholder()
            } else {
                gameItemImage(game.backgroundImage!)
            }
            HStack(
                alignment: .top,
                spacing: Space.small
            ) {
                Text(game.name ?? "")
                    .font(.body)
                    .lineLimit(3, reservesSpace: true)
                Spacer()
                FavoriteButton(
                    id: game.id?.description ?? "",
                    name: game.name ?? "",
                    backgroundImage: game.backgroundImage ?? "",
                    isSet: $game.isFavorite.toUnwrapped(defaultValue: false)
                )
            }
            .padding([.leading, .trailing, .bottom], Space.small)
        }
        .background(Color.surfaceColor)
        .cornerRadius(Shape.roundedCorner)
    }
}

struct GameFavoriteItem_Previews: PreviewProvider {
    static let gamesResponse: GamesResponse = PreviewData.load("games_response")

    static var previews: some View {
        GameFavoriteItem(game: FavoriteModel())
    }
}
