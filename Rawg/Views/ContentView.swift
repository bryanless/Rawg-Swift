//
//  ContentView.swift
//  Rawg
//
//  Created by Bryan on 11/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .home

    enum Tab {
        case home, explore, favorite, profile
    }

    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Label("Home", systemImage: Icons.house)
                }
                .tag(Tab.home)
            ExploreGrid()
                .tabItem {
                    Label("Explore", systemImage: Icons.magnifyingGlass)
                }
                .tag(Tab.explore)
            Favorite()
                .tabItem {
                    Label("Favorite", systemImage: Icons.heart)
                }
                .tag(Tab.favorite)
            Profile()
                .tabItem {
                    Label("Profile", systemImage: Icons.person)
                }
                .tag(Tab.profile)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
