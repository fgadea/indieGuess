//
//  ImageButtonView.swift
//  IndieGuess
//
//  Created by FELIPE GADEA LLOPIS on 21.6.2025.
//

import SwiftUI

struct ImageButtonView: View {
    var image: Image
    var foregroundColor: Color = .primary
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            image
                .font(.title2)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
        }
        .buttonStyle(.borderless)
        .foregroundStyle(foregroundColor)
        .glassEffect(.clear.interactive())
        .padding(6)
    }
}
