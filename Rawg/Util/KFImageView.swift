//
//  KFImageView.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import Foundation
import SwiftUI
import Kingfisher

func KFImageView(_ url: String) -> some View {
    return GeometryReader { geo in
        KFImage(URL(string: url))
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, alignment: .center)
    }
    .frame(height: 110)
    .cornerRadius(Shape.roundedCorner)
}
