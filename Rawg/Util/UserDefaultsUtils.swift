//
//  UserDefaultsUtils.swift
//  Rawg
//
//  Created by Bryan on 24/10/22.
//

import Foundation

class UserDefaultsUtils {
    static var shared = UserDefaultsUtils()
    func setDarkMode(enable: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(enable, forKey: Const.DARK_MODE)
    }

    func getDarkMode() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: Const.DARK_MODE)
    }

    func setProfileName(name: String) {
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: Const.PROFILE_NAME)
    }

    func getProfileName() -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: Const.PROFILE_NAME) ?? "Bryan"
    }

    func setProfileEmail(name: String) {
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: Const.PROFILE_EMAIL)
    }

    func getProfileEmail() -> String {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: Const.PROFILE_EMAIL) ?? "bryan001@student.ciputra.ac.id"
    }

    func setProfilePicture(data: Data) {
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: Const.PROFILE_PICTURE)
    }

    func getProfilePicture() -> Data? {
        let defaults = UserDefaults.standard
        return defaults.data(forKey: Const.PROFILE_PICTURE) ?? nil
    }
}
