//
//  UserIntent.swift
//  NumberGuess
//
//  Created by FELIPE GADEA LLOPIS on 21.6.2025.
//

import SwiftUI

struct UserIntent: Equatable, Identifiable {
    var id: UUID = UUID()
    var content: String
    var matches: Int
    var wrongMatches: Int
}
