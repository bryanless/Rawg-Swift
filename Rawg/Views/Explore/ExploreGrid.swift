//
//  ExploreGrid.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import SwiftUI

struct ExploreGrid: View {
    @StateObject var exploreViewModel: ExploreViewModel = ExploreViewModel()

    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

    var body: some View {
        switch exploreViewModel.currentState {
        case .start, .loading:
            ProgressView()
                .navigationTitle("Explore")
        case let .success(games):
            NavigationStack {
                ScrollView {
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
                .background(Color.green)
            }
        case let .failure(error):
            Text(error.localizedDescription)
                .navigationTitle("Explore")
        }
    }
}

struct ExploreGrid_Previews: PreviewProvider {
    static var previews: some View {
        ExploreGrid()
    }
}