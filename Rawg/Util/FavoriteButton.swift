//
//  FavoriteButton.swift
//  Rawg
//
//  Created by Bryan on 01/11/22.
//

import SwiftUI

struct FavoriteButton: View {
    var id: String
    var name: String
    var backgroundImage: String
    @Binding var isSet: Bool
    @Binding var refreshPrevious: Bool

    var body: some View {
        Button {
            UserProvider().updateFavorite(id: id, name: name, backgroundImage: backgroundImage, isFavorite: !isSet) {
                DispatchQueue.main.async {
                    isSet.toggle()
                    refreshPrevious.toggle()
                }
            }
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "heart.fill" : "heart")
                .labelStyle(IconOnlyLabelStyle())
                .foregroundColor(isSet ? .red : .gray)
                .font(.system(size: 24))
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(
            id: "0", name: "",
            backgroundImage: "",
            isSet: .constant(true),
            refreshPrevious: .constant(false)
        )
    }
}
