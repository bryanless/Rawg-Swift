//
//  RawgApp.swift
//  Rawg
//
//  Created by Bryan on 11/10/22.
//

import SwiftUI

@main
struct RawgApp: App {
    @AppStorage(Const.DARK_MODE) private var isDark = true

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDark ? .dark : .light)
        }
    }
}
