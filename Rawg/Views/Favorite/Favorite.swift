//
//  Favorite.swift
//  Rawg
//
//  Created by Bryan on 01/11/22.
//

import SwiftUI

struct Favorite: View {
    @StateObject private var favoriteViewModel = FavoriteViewModel()

    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        NavigationStack {
            switch favoriteViewModel.currentState {
            case .start, .loading:
                ProgressView()
                    .navigationTitle("Favorite")
            case .success:
                if favoriteViewModel.favoriteGames.isEmpty {
                    Text("No favorite game")
                        .foregroundColor(.secondary)
                        .padding()
                        .navigationTitle("Favorite")
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns) {
                            ForEach(favoriteViewModel.favoriteGames) { game in
                                NavigationLink {
                                    GameDetail(detailViewModel: DetailViewModel(id: game.id?.description ?? ""))
                                } label: {
                                    GameFavoriteItem(game: game)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                        .navigationTitle("Favorite")
                    }
                }
            case let .failure(error):
                Text(error.localizedDescription)
                    .onAppear {
                        print(error)
                    }
                    .padding()
                    .navigationTitle("Favorite")
            }
        }
        .onAppear {
            favoriteViewModel.getFavorites()
        }
    }
}

struct Favorite_Previews: PreviewProvider {
    static var previews: some View {
        Favorite()
    }
}
