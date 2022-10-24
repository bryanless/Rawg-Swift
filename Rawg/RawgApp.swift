//
//  RawgApp.swift
//  Rawg
//
//  Created by Bryan on 11/10/22.
//

import SwiftUI

@main
struct RawgApp: App {
    @StateObject private var mainViewModel = MainViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(mainViewModel.colorScheme)
                .environmentObject(mainViewModel)
        }
    }
}
