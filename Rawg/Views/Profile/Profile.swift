//
//  Profile.swift
//  Rawg
//
//  Created by Bryan on 24/10/22.
//

import SwiftUI

struct Profile: View {
    @AppStorage(Const.DARK_MODE) private var isDark = true
    @StateObject private var profileViewModel = ProfileViewModel()

    var body: some View {
        NavigationStack {
            Form {
                NavigationLink {
                    ProfileEdit(profileViewModel: profileViewModel)
                } label: {
                    HStack {
                        Image(uiImage: profileViewModel.profilePicture)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .padding(.trailing, Space.small)
                        VStack(
                            alignment: .leading,
                            spacing: Space.tiny
                        ) {
                            Text(profileViewModel.name)
                                .font(.title)
                                .lineLimit(1)
                            Text(profileViewModel.email)
                                .font(.caption)
                                .lineLimit(1)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
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
