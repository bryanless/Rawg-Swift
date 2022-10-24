//
//  Profile.swift
//  Rawg
//
//  Created by Bryan on 24/10/22.
//

import SwiftUI

struct Profile: View {
    @AppStorage(Const.DARK_MODE) private var isDark = true

    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Image("ProfilePicture")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 80)
                        .padding(.trailing, Space.small)
                    Text("Bryan")
                        .font(.title)
                    Spacer()
                }
                .padding([.top, .bottom], Space.tiny)
                Section(header: Text("Theme")) {
                    Toggle(isOn: $isDark) {
                        Text("Dark mode")
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
