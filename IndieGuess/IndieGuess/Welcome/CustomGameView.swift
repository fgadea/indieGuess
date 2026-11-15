//
//  CustomGameView.swift
//  IndieGuess
//
//  Created by FELIPE GADEA LLOPIS on 21.6.2025.
//

import SwiftUI

struct CustomGameView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding var isPresented: Bool
    @Binding var selectedLevel: DifficultyLevel?
    @Binding var customLength: Int
    @Binding var customAttempts: Int
    @State private var showBackground: Bool = false
    
    var body: some View {
        ZStack {
            if showBackground {
                Color.primary.opacity(0.2)
                    .ignoresSafeArea()
                    .onTapGesture {
                        customDismiss()
                    }
            }
            VStack(spacing: 28) {
                Text("Custom Game")
                    .font(.title.bold())
                
                VStack(spacing: 20) {
                    CustomStepperView(title: "Number length", value: $customLength, range: 1...50)
                    CustomStepperView(title: "Max attempts", value: $customAttempts, range: 1...50)
                }
                
                HStack(spacing: 16) {
                    Button {
                        customDismiss()
                    } label: {
                        Text("Cancel")
                            .font(.headline)
                            .frame(minWidth: 100, minHeight: 20)
                            .padding()
                            .background(CustomAlertButtonStyle.cancel.backgroundColor(for: colorScheme))
                            .foregroundColor(CustomAlertButtonStyle.cancel.textColor(for: colorScheme))
                            .clipShape(Capsule(style: .continuous))
                    }
                    .glassEffect(
                        .clear.interactive()
                    )
                    #if os(iOS)
                    .sensoryFeedback(.impact(weight: .heavy), trigger: showBackground)
                    #endif
                    
                    Button {
                        selectedLevel = .custom
                        customDismiss()
                    } label: {
                        Text("Start")
                            .font(.headline)
                            .frame(minWidth: 100, minHeight: 20)
                            .padding()
                            .background(CustomAlertButtonStyle.start.backgroundColor(for: colorScheme))
                            .foregroundColor(CustomAlertButtonStyle.start.textColor(for: colorScheme))
                            .clipShape(Capsule(style: .continuous))
                    }
                    .glassEffect(
                        .clear.interactive()
                    )
                    #if os(iOS)
                    .sensoryFeedback(.impact(weight: .heavy), trigger: showBackground)
                    #endif

                }
            }
            .padding(28)
            .background(.background)
            .cornerRadius(30)
            .shadow(radius: 5)
            .padding()
            .frame(maxWidth: 400)
        }
        .toolbarVerticalBehavior(.disabled)
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8)) {
                showBackground = true
            }
        }
    }
    
    func customDismiss() {
        withAnimation(.easeInOut(duration: 0.1)) {
            showBackground = false
        } completion: {
            isPresented = false
        }
    }
}
