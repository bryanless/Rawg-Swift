//
//  ContentView.swift
//  Rawg
//
//  Created by Bryan on 11/10/22.
//

import SwiftUI

struct ContentView: View {
    @State private var presentedNumbers = NavigationPath()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()

        NavigationStack(path: $presentedNumbers) {
            NavigationLink(value: "Example") {
                Text("Tap Me")
            }

            List(1..<50) { i in
                NavigationLink(value: i) {
                    Label("Row \(i)", systemImage: "\(i).circle")
                }
            }
            .navigationDestination(for: Int.self) { i in
                Text("Detail \(i)")
            }
            .navigationDestination(for: String.self) { i in
                Text("String Detail \(i)")
            }
            .navigationTitle("Navigation")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
