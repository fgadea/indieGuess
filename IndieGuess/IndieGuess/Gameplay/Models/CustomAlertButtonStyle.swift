//
//  AlertButtons.swift
//  IndieGuess
//
//  Created by FELIPE GADEA LLOPIS on 15/11/2026.
//

import SwiftUI

enum CustomAlertButtonStyle: LocalizedStringKey {
    case cancel = "Cancel"
    case start = "Start"

    func backgroundColor(for scheme: ColorScheme) -> Color {
        switch self {
        case .cancel:
            return scheme == .light ? Color.red.opacity(0.2) : .red
        case .start:
            return scheme == .light ? Color.green.opacity(0.2) : .green
        }
    }

    func textColor(for scheme: ColorScheme) -> Color {
        scheme == .light ? foregroundColor : .black
    }

    private var foregroundColor: Color {
        switch self {
        case .cancel:
            return Color(hue: 0, saturation: 0.9, brightness: 0.35)
        case .start:
            return Color(hue: 0.33, saturation: 0.8, brightness: 0.3)
        }
    }
}
