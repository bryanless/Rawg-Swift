//
//  ProfileEdit.swift
//  Rawg
//
//  Created by Bryan on 04/11/22.
//

import SwiftUI
import PhotosUI

struct ProfileEdit: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var profileViewModel: ProfileViewModel
    @State private var selectedItem: PhotosPickerItem?
    @State private var profilePictureData: Data?
    @State private var name: String = ""
    @State private var email: String = ""

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: Space.large) {
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    ZStack(alignment: .bottom) {
                        Image(uiImage: profileViewModel.profilePicture)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                        ZStack {
                            Text("Edit")
                                .font(.caption)
                                .foregroundColor(.white)
                        }
                        .frame(width: 120, height: 20)
                        .padding(.bottom, Space.tiny)
                        .background(Color.formColor)
                    }
                    .clipShape(Circle())
                }
                .onChange(of: selectedItem) { newItem in
                    profileViewModel.changeProfilePicture(item: newItem)
                }

                VStack(alignment: .leading) {
                    Text("Name")
                        .foregroundColor(.secondary)
                    TextField("Name", text: $name)
                        .autocorrectionDisabled()
                        .padding()
                        .background(Color.formColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                VStack(alignment: .leading) {
                    Text("Email")
                        .foregroundColor(.secondary)
                    TextField("Name", text: $email)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                        .padding()
                        .background(Color.formColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                Button {
                    profileViewModel.saveProfile(name, email) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Text("Save")
                        .padding(.vertical, Space.tiny)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .onAppear {
                self.name = profileViewModel.name
                self.email = profileViewModel.email
            }
            .padding()
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ProfileEdit_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEdit(profileViewModel: ProfileViewModel())
    }
}
