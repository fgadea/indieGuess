//
//  DifficultyPillView.swift
//  IndieGuess
//
//  Created by FELIPE GADEA LLOPIS on 21.6.2025.
//

import SwiftUI

struct DifficultyPillView: View {
    let level: DifficultyLevel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Text(level.rawValue)
            .font(.caption.bold())
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(level.backgroundColor(for: colorScheme))
            .foregroundColor(level.textColor(for: colorScheme))
            .clipShape(Capsule())
    }
}
