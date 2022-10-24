//
//  MainViewModel.swift
//  Rawg
//
//  Created by Bryan on 24/10/22.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var colorScheme: ColorScheme

    init() {
        self.colorScheme = UserDefaultsUtils.shared.getDarkMode() ? ColorScheme.dark : ColorScheme.light
    }
}
