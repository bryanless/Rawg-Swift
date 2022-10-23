//
//  RatingView.swift
//  Rawg
//
//  Created by Bryan on 22/10/22.
//

import SwiftUI

struct RatingView: View {
    @State var rating: Double

    var body: some View {
        let ratingFloor = Int(floor(rating))
        let ratingDecimal = rating.truncatingRemainder(dividingBy: 1)

        HStack(spacing: 0) {
            ForEach(0..<5, id: \.self) { index in
                if index < ratingFloor || ratingDecimal >= 0.75 {
                    Image(systemName: Icons.star)
                } else if index == ratingFloor && ratingDecimal >= 0.25 {
                    Image(systemName: Icons.starLeadingHalf)
                } else {
                    Image(systemName: Icons.starOutlined)
                }
            }
        }
        .foregroundColor(.secondary)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: 4.5)
    }
}
