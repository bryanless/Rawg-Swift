//
//  ProfileViewModel.swift
//  Rawg
//
//  Created by Bryan on 04/11/22.
//

import Foundation
import SwiftUI
import PhotosUI

class ProfileViewModel: ObservableObject {
    @Published var profilePicture: UIImage = UIImage(named: "ProfilePicture")!
    @Published var name: String = ""
    @Published var email: String = ""

    // MARK: - Get profile
    func getProfile() {
        self.name = UserDefaultsUtils.shared.getProfileName()
        self.email = UserDefaultsUtils.shared.getProfileEmail()
    }

    // MARK: - Save profile
    func saveProfile(_ name: String, _ email: String, completion: @escaping () -> Void) {
        UserDefaultsUtils.shared.setProfileName(name: name)
        UserDefaultsUtils.shared.setProfileEmail(name: email)
        getProfile()
        completion()
    }

    // MARK: - Change profile picture
    func changeProfilePicture(item: PhotosPickerItem?) {
        Task {
            if let data = try? await item?.loadTransferable(type: Data.self) {
                DispatchQueue.main.async {
                    self.saveProfilePicture(data: data)
                }
            }
        }
    }

    // MARK: Load profile picture
    func loadProfilePicture() {
        guard let data = UserDefaultsUtils.shared.getProfilePicture() else {
            profilePicture = UIImage(named: "ProfilePicture")!
            return
        }

        guard let decoded = try? PropertyListDecoder().decode(Data.self, from: data) else {
            profilePicture = UIImage(named: "ProfilePicture")!
            return
        }

        profilePicture = UIImage(data: decoded)!
    }

    // MARK: Save profile picture
    func saveProfilePicture(data: Data) {
        guard let encoded = try? PropertyListEncoder().encode(data) else {
            return
        }

        UserDefaultsUtils.shared.setProfilePicture(data: encoded)
        self.loadProfilePicture()
    }

    init() {
        getProfile()
    }
}
