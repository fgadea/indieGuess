//
//  DifficultyLevel.swift
//  IndieGuess
//
//  Created by FELIPE GADEA LLOPIS on 21.6.2025.
//

import SwiftUI

enum DifficultyLevel: LocalizedStringKey, CaseIterable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    case custom = "Custom"

    func backgroundColor(for scheme: ColorScheme) -> Color {
        switch self {
        case .easy:
            return scheme == .light ? Color.green.opacity(0.2) : .green
        case .medium:
            return scheme == .light ? Color.orange.opacity(0.2) : .orange
        case .hard:
            return scheme == .light ? Color.red.opacity(0.2) : .red
        case .custom:
            return scheme == .light ? Color.blue.opacity(0.2) : .blue
        }
    }

    func textColor(for scheme: ColorScheme) -> Color {
        scheme == .light ? foregroundColor : .black
    }

    private var foregroundColor: Color {
        switch self {
        case .easy:
            return Color(hue: 0.33, saturation: 0.8, brightness: 0.3)
        case .medium:
            return Color(hue: 0.09, saturation: 0.8, brightness: 0.35)
        case .hard:
            return Color(hue: 0, saturation: 0.9, brightness: 0.35)
        case .custom:
            return Color(hue: 0.6, saturation: 0.8, brightness: 0.35)
        }
    }
}
