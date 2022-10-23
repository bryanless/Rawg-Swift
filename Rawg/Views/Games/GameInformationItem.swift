//
//  GameInformationItem.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import SwiftUI

struct GameInformationItem: View {
    @State var label: String
    @State var text: String

    var body: some View {
        VStack(
            alignment: .leading
        ) {
            Text(label)
                .foregroundColor(.secondary)
            Text(text)
        }
    }
}

struct GameInformationItem_Previews: PreviewProvider {
    static var previews: some View {
        GameInformationItem(label: "Release Date", text: "September 28, 2022")
    }
}
