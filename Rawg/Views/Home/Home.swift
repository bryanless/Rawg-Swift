//
//  Home.swift
//  Rawg
//
//  Created by Bryan on 24/10/22.
//

import SwiftUI

struct Home: View {
    @StateObject private var homeViewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(
                    spacing: Space.large
                ) {
                    GameRow(currentState: $homeViewModel.currentRecentlyUpdatedState, headline: "Recently Updated")
                    GameRow(currentState: $homeViewModel.currentTopRatedState, headline: "Top Rated")
                    GameRow(currentState: $homeViewModel.currentLatestReleasedState, headline: "Latest Released")
                }
                .padding(.vertical, Space.medium)
            }
            .navigationTitle("Home")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
