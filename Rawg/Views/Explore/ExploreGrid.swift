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
            GeometryReader { geo in
                ScrollView {
                    switch exploreViewModel.currentState {
                    case .start, .loading:
                        ProgressView()
                            .frame(minWidth: geo.size.width, minHeight: geo.size.height)
                            .navigationTitle("Explore")
                    case let .success(games):
                        if games.isEmpty {
                            Text("No game found")
                                .foregroundColor(.secondary)
                                .frame(minWidth: geo.size.width, minHeight: geo.size.height)
                                .navigationTitle("Explore")
                        } else {
                            LazyVGrid(columns: columns) {
                                ForEach(games) { game in
                                    NavigationLink {
                                        GameDetail(detailViewModel: DetailViewModel(id: game.id.description))
                                    } label: {
                                        GameItem(game: game)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding()
                            .navigationTitle("Explore")
                        }
                    case let .failure(error):
                        Text(error.localizedDescription)
                            .onAppear {
                                print(error)
                            }
                            .navigationTitle("Explore")
                    }
                }
                .frame(minHeight: geo.size.height)
                .searchable(
                    text: $searchText,
                    prompt: Text("Search a game")
                )
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
    }
}

struct ExploreGrid_Previews: PreviewProvider {
    static var previews: some View {
        ExploreGrid()
    }
}
