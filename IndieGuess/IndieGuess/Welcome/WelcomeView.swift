//
//  WelcomeView.swift
//  IndieGuess
//
//  Created by FELIPE GADEA LLOPIS on 21.6.2025.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var selectedLevel: DifficultyLevel? = nil
    @State private var showGameplay: Bool = false
    @State private var showCustomAlert: Bool = false
    @State private var showContent: Bool = false
    @State private var showTitle: Bool = false
    @State private var customLength: Int = 10
    @State private var customAttempts: Int = 5
    
    func createGamePlayModel() -> GamePlayModel {
        switch selectedLevel ?? .custom {
        case .easy:
            .init(digits: 3, attemps: 10, level: selectedLevel ?? .custom)
        case .medium:
                .init(digits: 6, attemps: 20, level: selectedLevel ?? .custom)
        case .hard:
                .init(digits: 10, attemps: 40, level: selectedLevel ?? .custom)
        case .custom:
                .init(digits: Int(customLength), attemps: Int(customAttempts), level: selectedLevel ?? .custom)
        }
    }
    
    private var getOrientation: DeviceOrientations {
        if horizontalSizeClass == .compact {
            return verticalSizeClass == .regular ? .compactPortrail : .compactLandscape
        }
        return .regular
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                if showTitle {
                    Text("Welcome")
                        .font(.largeTitle.bold())
                        .task {
                            try? await Task.sleep(for: .seconds(2))
                            withAnimation {
                                showContent = true
                            }
                        }
                }
                if showContent {
                    Text("Choose your difficulty")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    
                    
                    if getOrientation == .compactLandscape {
                        HStack(spacing: 0) {
                            gameButtonsView(Array(DifficultyLevel.allCases.prefix(DifficultyLevel.allCases.count / 2)))
                            gameButtonsView(Array(DifficultyLevel.allCases.suffix(DifficultyLevel.allCases.count / 2)))
                        }
                    } else {
                        gameButtonsView(DifficultyLevel.allCases)
                    }
                }
            }
            .padding()
            .toolbarVerticalBehavior(.disabled)
            .navigationDestination(isPresented: $showGameplay) {
                let model = createGamePlayModel()
                GameplayView(model: model)
                    .onAppear {
                        model.reset()
                    }
                    .onDisappear {
                        selectedLevel = nil
                    }
            }
            #if os(macOS)
            .sheet(isPresented: $showCustomAlert, content: {
                CustomGameView(
                    isPresented: $showCustomAlert,
                    selectedLevel: $selectedLevel,
                    customLength: $customLength,
                    customAttempts: $customAttempts
                )
                .onDisappear {
                    if selectedLevel == .custom {
                        showGameplay = true
                    }
                }
            })
            #else
            .fullScreenCover(isPresented: $showCustomAlert) {
                CustomGameView(
                    isPresented: $showCustomAlert,
                    selectedLevel: $selectedLevel,
                    customLength: $customLength,
                    customAttempts: $customAttempts
                )
                .onDisappear {
                    if selectedLevel == .custom {
                        showGameplay = true
                    }
                }
            }
            #endif
            #if os(iOS)
            .sensoryFeedback(.success, trigger: showTitle)
            .sensoryFeedback(.success, trigger: showContent)
            .sensoryFeedback(.success, trigger: showGameplay)
            .sensoryFeedback(.success, trigger: showCustomAlert)
            #endif
            .task {
                try? await Task.sleep(for: .seconds(2))
                withAnimation {
                    showTitle = true
                }
            }
        }
    }
    
    private func gameButtonsView(_ buttons: [DifficultyLevel]) -> some View {
        VStack(spacing: 16) {
            ForEach(buttons, id: \.self) { level in
                Button {
                    if level == .custom {
                        showCustomAlert = true
                    } else {
                        selectedLevel = level
                        showGameplay = true
                    }
                } label: {
                    Text(level.rawValue)
                        .font(.headline)
                        .frame(width: 200, height: 40)
                        .padding()
                        .background(level.backgroundColor(for: colorScheme))
                        .foregroundColor(level.textColor(for: colorScheme))
                        .clipShape(Capsule(style: .continuous))
                }
                .glassEffect(
                    .clear.interactive()
                )
                
            }
        }
        .padding(.horizontal)
    }
}


#Preview {
    WelcomeView()
}
