//
//  StepperButtonStyle.swift
//  IndieGuess
//
//  Created by FELIPE GADEA LLOPIS on 15/11/2026.
//

import SwiftUI

enum StepperButtonStyle {
    case add
    case sub

    func backgroundColor(for scheme: ColorScheme) -> Color {
        switch self {
        case .add, .sub:
            return scheme == .light ? Color.blue.opacity(0.2) : .blue
        }
    }

    func textColor(for scheme: ColorScheme) -> Color {
        scheme == .light ? foregroundColor : .black
    }

    private var foregroundColor: Color {
        switch self {
        case .add, .sub:
            return Color(hue: 0.6, saturation: 0.8, brightness: 0.35)
        }
    }
}
