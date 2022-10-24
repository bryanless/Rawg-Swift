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
}
