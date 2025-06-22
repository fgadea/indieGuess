//
//  CustomGameView.swift
//  NumberGuess
//
//  Created by FELIPE GADEA LLOPIS on 21.6.2025.
//

import SwiftUI

struct CustomGameView: View {
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
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 12))
                    #if os(iOS)
                    .sensoryFeedback(.impact(weight: .heavy), trigger: showBackground)
                    #endif
                    
                    Button {
                        selectedLevel = .custom
                        customDismiss()
                    } label: {
                        Text("Start")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.roundedRectangle(radius: 12))
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
