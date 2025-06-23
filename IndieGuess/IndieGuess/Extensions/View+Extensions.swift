//
//  View+Extensions.swift
//  IndieGuess
//
//  Created by FELIPE GADEA LLOPIS on 21.6.2025.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content) -> some View {
            if condition {
                transform(self)
            } else {
                self
            }
        }
}
