//
//  View+OnValueChanged.swift
//  Nea
//
//  Created by Ritesh Pakala Rao on 5/12/23.
//
import SwiftUI
import Combine

extension View {
    /// A backwards compatible wrapper for iOS 14 `onChange`
    @ViewBuilder func onValueChanged<T: Equatable>(of value: T, perform onChange: @escaping (T) -> Void) -> some View {
        if #available(iOS 14.0, *) {
            self.onChange(of: value, perform: onChange)
        } else {
            self.onReceive(Just(value)) { (value) in
                onChange(value)
            }
        }
    }
}
