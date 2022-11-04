//
//  GameRow.swift
//  Rawg
//
//  Created by Bryan on 24/10/22.
//

import SwiftUI

struct GameRow: View {
    @Binding var currentState: HomeViewModel.ViewState
    let headline: String

    var body: some View {
        VStack {
            HStack {
                Text(headline)
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal, Space.medium)
            switch currentState {
            case .start, .loading:
                ProgressView()
                    .frame(height: 170)
            case let .success(games):
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(games) { game in
                            NavigationLink {
                                GameDetail(detailViewModel: DetailViewModel(id: game.id.description), refreshPrevious: .constant(false))
                            } label: {
                                GameItem(game: game)
                                    .frame(width: 175)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, Space.medium)
                }
            case let .failure(error):
                Text(error.localizedDescription)
                    .onAppear {
                        print(error)
                    }
                    .padding()
            }
        }
    }
}

struct GameRow_Previews: PreviewProvider {
    static let games: GamesResponse = PreviewData.load("games_top_rated_response")

    static var previews: some View {
        GameRow(currentState: .constant(HomeViewModel.ViewState.success(games.results)), headline: "Top Rated")
    }
}
