//
//  Gameplay.swift
//  NumberGuess
//
//  Created by FELIPE GADEA LLOPIS on 21.6.2025.
//

import SwiftUI

struct GameplayView: View {
    @State private var model: GamePlayModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var showWinView: Bool = false
    @State private var showLooseView: Bool = false
    var numpadRow1: [Int] = [1,2,3]
    var numpadRow2: [Int] = [4,5,6]
    var numpadRow3: [Int] = [7,8,9]
    var numpadRow4: [Int] = [0]
    
    init(model: GamePlayModel) {
        self.model = model
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Guess the number")
                    .font(.system(size: 36, weight: .black))
                    .lineLimit(1)
            }
            
            HStack(alignment: .top) {
                HStack {
                    Text("Difficulty:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    DifficultyPillView(level: model.level)
                }
                .frame(height: 35)
                Spacer()
                HStack {
                    Text("Attempts:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("\(model.userIntents.count) / \(model.attemps)")
                        .font(.subheadline)
                        .font(.subheadline.bold())
                        .foregroundColor(.primary)
                }
                .frame(height: 35)
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            ScrollViewReader { proxy in
                List(model.userIntents) { intent in
                    HStack {
                        Text(intent.content)
                            .font(.system(.title3, design: .monospaced))

                        Spacer()
                        Text("\(intent.matches)")
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                            .padding(.trailing, 6)

                        Text("\(intent.wrongMatches)")
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.orange)
                    }
                    .padding()
                    .background(colorScheme == .dark ? Color.white.opacity(0.1) :  Color.black.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 4, leading: 0, bottom: 4, trailing: 0))
                    .id(intent.id)
                    .accessibilityLabel(Text("tried \(intent.content) with \(intent.matches) matches and \(intent.wrongMatches) wrong matches."))
                }
                .listStyle(.plain)
                .padding(.horizontal)
                .padding(.bottom)
                .onChange(of: model.userIntents) { _, _ in
                    withAnimation {
                        proxy.scrollTo(model.userIntents.last?.id)
                    }
                }
            }
            
            inputRowView
                .padding()
            numPadView
                .frame(maxWidth: 400, minHeight: 280, maxHeight: 280)
                .padding()
        }
        .onChange(of: model.userIntents) {
            guard let last = model.userIntents.last else { return }
            if last.matches == model.digits {
                showWinView = true
                
            } else if model.userIntents.count == model.attemps {
                showLooseView = true
            }
        }
        .alert("You win!", isPresented: $showWinView) {
            Button("Go to menu") {
                dismiss()
            }
            Button("Play again!") {
                model.reset()
            }
        }
        .alert("You loose!", isPresented: $showLooseView) {
            Button("Go to menu") {
                dismiss()
            }
            Button("Play again!") {
                model.reset()
            }
        }
        #if os(iOS)
        .sensoryFeedback(.increase, trigger: model.userInput)
        .sensoryFeedback(.error, trigger: showLooseView)
        .sensoryFeedback(.success, trigger: showWinView)
        #endif
    }
    
    private var inputRowView: some View {
        HStack(spacing: 12) {
            if model.digits > 10 {
                LazyVGrid(columns: .init(repeating: .init(), count: 10)) {
                    ForEach(0..<model.digits, id: \ .self) { index in
                        Rectangle()
                            .fill(.clear)
                            .frame(width: 15, height: 15)
                            .overlay {
                                if index < model.userInput.count {
                                    Text("\(Array(model.userInput)[index])")
                                        .font(.system(.title3, design: .monospaced))
                                } else {
                                    Circle()
                                        .fill(colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2))
                                        .frame(width: 10, height: 10)
                                }
                            }
                    }
                }
            } else {
                ForEach(0..<model.digits, id: \ .self) { index in
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 15, height: 15)
                        .overlay {
                            if index < model.userInput.count {
                                Text("\(Array(model.userInput)[index])")
                                    .font(.system(.title3, design: .monospaced))
                            } else {
                                Circle()
                                    .fill(colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2))
                                    .frame(width: 10, height: 10)
                            }
                        }
                }
            }
        }
    }
    
    private var numPadView: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(numpadRow1, id: \.self) { num in
                    NumberButtonView(num: num) {
                        model.input($0)
                    }
                }
            }
            HStack(spacing: 0) {
                ForEach(numpadRow2, id: \.self) { num in
                    NumberButtonView(num: num) {
                        model.input($0)
                    }
                }
            }
            HStack(spacing: 0) {
                ForEach(numpadRow3, id: \.self) { num in
                    NumberButtonView(num: num) {
                        model.input($0)
                    }
                }
            }
            HStack(spacing: 0) {
                ImageButtonView(
                    image: Image(systemName: "eraser.fill"),
                    foregroundColor: .red
                ) {
                    model.removeInput()
                }
                ForEach(numpadRow4, id: \.self) { num in
                    NumberButtonView(num: num) {
                        model.input($0)
                    }
                }
                ImageButtonView(
                    image: Image(systemName: "paperplane.fill"),
                    foregroundColor: .green
                ) {
                    model.send()
                }
            }
        }
    }
}

#Preview {
    GameplayView(model: .init(digits: 3, attemps: 5, level: .custom))
}
