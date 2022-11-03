//
//  BindingUtils.swift
//  Rawg
//
//  Created by Bryan on 04/11/22.
//

import SwiftUI

// Credit: https://stackoverflow.com/a/68544010
extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == T? {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}
