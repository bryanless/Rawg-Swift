//
//  KFImageView.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import Foundation
import SwiftUI
import Kingfisher

func KFImageView(_ urlString: String) -> KFImage {
    return KFImage.url(URL(string: urlString))
        .placeholder {
            ProgressView()
        }
        .downsampling(size: CGSize(width: 1920, height: 1080))
        .fade(duration: 0.5)
}

func gameItemImagePlaceholder() -> some View {
    return GeometryReader { geo in
        Image(systemName: Icons.photo)
            .frame(width: geo.size.width, height: 110, alignment: .center)
    }
}

func gameDetailImagePlaceholder() -> some View {
    return Image(systemName: Icons.photo)
        .font(.system(size: 80))
        .frame(height: 200)
}

func gameItemImage(_ urlString: String) -> some View {
    return GeometryReader { geo in
        KFImageView(urlString)
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, alignment: .center)
    }
    .frame(height: 110)
    .clipped()
}

func gameDetailImage(_ urlString: String) -> some View {
    return KFImageView(urlString)
        .resizable()
        .scaledToFit()
}
