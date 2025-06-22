//
//  NumberButtonView.swift
//  NumberGuess
//
//  Created by FELIPE GADEA LLOPIS on 21.6.2025.
//

import SwiftUI

struct NumberButtonView: View {
    @Environment(\.colorScheme) var colorScheme
    var num: Int
    var action: (Int) -> Void
    
    var body: some View {
        Button {
            action(num)
        } label: {
            Text("\(num)")
                .font(.title2)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
        }
        .buttonStyle(.borderless)
        .foregroundStyle(.primary)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.quinary)
                )
        .padding(6)
    }
}
