//
//  ExploreGrid.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import SwiftUI

struct ExploreGrid: View {
    @Environment(\.isSearching) private var isSearching: Bool
    @StateObject private var exploreViewModel: ExploreViewModel = ExploreViewModel()
    @State private var searchText = ""

    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        NavigationStack {
            switch exploreViewModel.currentState {
            case .start, .loading:
                ProgressView()
                    .navigationTitle("Explore")
            case let .success(games):
                if games.isEmpty {
                    Text("No game found")
                        .foregroundColor(.secondary)
                        .padding()
                        .navigationTitle("Explore")
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns) {
                            ForEach(games) { game in
                                NavigationLink {
                                    GameDetail(
                                        detailViewModel: DetailViewModel(id: game.id.description),
                                        refreshPrevious: .constant(false)
                                    )
                                } label: {
                                    GameItem(game: game)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding()
                        .navigationTitle("Explore")
                    }
                }
            case let .failure(error):
                Text(error.localizedDescription)
                    .onAppear {
                        print(error)
                    }
                    .padding()
                    .navigationTitle("Explore")
            }
        }
        .searchable(
            text: $searchText,
            prompt: Text("Search a game")
        )
        .disableAutocorrection(true)
        .onSubmit(of: .search) {
            exploreViewModel.searchGames(searchText: searchText)
        }
        .onChange(of: searchText) { _ in
            if searchText.isEmpty && !isSearching {
                exploreViewModel.searchGames(searchText: "")
            }
        }
    }
}

struct ExploreGrid_Previews: PreviewProvider {
    static var previews: some View {
        ExploreGrid()
    }
}
