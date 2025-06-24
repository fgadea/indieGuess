//
//  GamePlayModel.swift
//  IndieGuess
//
//  Created by FELIPE GADEA LLOPIS on 21.6.2025.
//

import SwiftUI

@Observable
class GamePlayModel {
    var digits: Int
    var attemps: Int
    var level: DifficultyLevel
    var numberToGuess: String = ""
    var userInput: String = ""
    var userIntents: [UserIntent] = []
    
    init(digits: Int, attemps: Int, level: DifficultyLevel) {
        self.digits = digits
        self.attemps = attemps
        self.level = level
    }
    
    func generateNumberToGuess() -> String {
        numberToGuess = ""
        for _ in 1...digits {
            numberToGuess += "\(Int.random(in: 0...9))"
        }
        return numberToGuess
    }
    
    func input(_ num: Int) {
        guard userInput.count < digits else { return }
        userInput += "\(num)"
    }
    
    func removeInput() {
        guard !userInput.isEmpty else { return }
        userInput.removeLast()
    }
    
    func send() {
        guard userInput.count == digits else { return }
        let userIntent = validateInput()
        userIntents.append(userIntent)
        userInput = ""
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIAccessibility.post(notification: .announcement, argument: "tried \(userIntent.content) with \(userIntent.matches) matches and \(userIntent.wrongMatches) wrong matches.")
        }
    }
    
    func reset() {
        userIntents.removeAll()
        numberToGuess = generateNumberToGuess()
        print(numberToGuess)
    }
    
    private func validateInput() -> UserIntent {
        let guess = Array(numberToGuess)
        let input = Array(userInput)

        var exactMatches = 0
        var wrongMatches = 0

        var unmatchedGuess: [Character] = []
        var unmatchedInput: [Character] = []

        // Step 1: Collect exact matches
        for i in 0..<min(guess.count, input.count) {
            if guess[i] == input[i] {
                exactMatches += 1
            } else {
                unmatchedGuess.append(guess[i])
                unmatchedInput.append(input[i])
            }
        }

        // Step 2: Count frequencies of unmatched guess digits
        var guessFreq: [Character: Int] = [:]
        for char in unmatchedGuess {
            guessFreq[char, default: 0] += 1
        }

        // Step 3: Count wrong matches
        for char in unmatchedInput {
            if let count = guessFreq[char], count > 0 {
                wrongMatches += 1
                guessFreq[char]! -= 1
            }
        }

        return UserIntent(content: userInput, matches: exactMatches, wrongMatches: wrongMatches)
    }
}
