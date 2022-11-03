//
//  GameDetail.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import SwiftUI

struct GameDetail: View {
    @StateObject var detailViewModel: DetailViewModel

    var body: some View {
        switch detailViewModel.currentState {
        case .start, .loading:
            ProgressView()
                .navigationTitle("Game Detail")
                .navigationBarTitleDisplayMode(.inline)
        case let .success(game):
            ScrollView(showsIndicators: false) {
                VStack(
                    spacing: Space.none
                ) {
                    if game.backgroundImage == nil {
                        gameDetailImagePlaceholder()
                    } else {
                        gameDetailImage(game.backgroundImage!)
                    }

                    VStack(
                        alignment: .leading,
                        spacing: Space.medium
                    ) {
                        HStack {
                            Text(game.name)
                                .font(.title)
                            .fontWeight(.bold)
                            Spacer()
                            FavoriteButton(
                                id: game.id.description,
                                name: game.name,
                                backgroundImage: game.backgroundImage ?? "",
                                isSet: $detailViewModel.isFavorite
                            )
                        }
                        Divider()
                        HStack {
                            GameRateItem(
                                label: "\(Formatter.formatNumber(game.ratingsCount)) RATINGS",
                                title: game.rating.description,
                                text: { RatingView(rating: game.rating) }
                            )
                            Divider()
                            GameRateItem(
                                label: "METASCORE",
                                title: game.metacritic?.description ?? "-",
                                text: { Text("Point") }
                            )
                            Divider()
                            GameRateItem(
                                label: "AGE",
                                title: game.esrbRating?.slug.toAge().rawValue ?? "-",
                                text: { Text("Years Old") }
                            )
                        }
                        .frame(maxWidth: .infinity)
                        Divider()
                        if game.descriptionRaw.isEmpty {
                            Text("No description")
                                .foregroundColor(.secondary)
                        } else {
                            Text(game.descriptionRaw)
                        }
                        Divider()
                        VStack(
                            alignment: .leading,
                            spacing: Space.small
                        ) {
                            Text("Information")
                                .font(.title2)
                                .fontWeight(.bold)
                            GameInformationItem(
                                label: "Genres",
                                text: game.genres.isEmpty ? "-" : game.genres.map { genre in
                                    genre.name
                                }.joined(separator: ", ")
                            )
                            GameInformationItem(
                                label: "Developer",
                                text: game.developers.isEmpty ? "-" : game.developers.map { developer in
                                    developer.name
                                }.joined(separator: ", ")
                            )
                            GameInformationItem(
                                label: "Publisher",
                                text: game.publishers.isEmpty ? "-" : game.publishers.map { publisher in
                                    publisher.name
                                }.joined(separator: ", ")
                            )
                            GameInformationItem(
                                label: "Release Date",
                                text: game.released!
                            )
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                detailViewModel.getFavoriteById(game.id.description)
            }
            .navigationTitle("Game Detail")
            .navigationBarTitleDisplayMode(.inline)
        case let .failure(error):
            Text(error.localizedDescription)
                .onAppear {
                    print(error)
                }
                .navigationTitle("Game Detail")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct GameDetail_Previews: PreviewProvider {
    static var previews: some View {
        GameDetail(detailViewModel: DetailViewModel(id: "401805"))
    }
}
