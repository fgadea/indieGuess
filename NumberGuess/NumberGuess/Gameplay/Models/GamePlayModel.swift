//
//  GamePlayModel.swift
//  NumberGuess
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
        var copyNumberToGuess = Array(numberToGuess)
        var exactMatches: Int = 0
        var wrongMatches: Int = 0
        for (index, number) in userInput.enumerated() {
            if copyNumberToGuess.contains(number), let firstIndex = copyNumberToGuess.firstIndex(of: number) {
                if copyNumberToGuess[index] == number {
                    exactMatches += 1
                } else if Int(String(copyNumberToGuess[firstIndex])) != nil {
                    wrongMatches += 1
                }
                copyNumberToGuess[firstIndex] = "x"
            }
        }
        
        return UserIntent(content: userInput, matches: exactMatches, wrongMatches: wrongMatches)
    }
}
