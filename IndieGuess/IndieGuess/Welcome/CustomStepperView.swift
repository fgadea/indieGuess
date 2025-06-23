//
//  CustomStepperView.swift
//  IndieGuess
//
//  Created by FELIPE GADEA LLOPIS on 21.6.2025.
//

import SwiftUI

struct CustomStepperView: View {
    let title: LocalizedStringKey
    @Binding var value: Int
    let range: ClosedRange<Int>

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 4)

            HStack(spacing: 32) {
                Button(action: {
                    if value > range.lowerBound {
                        value -= 1
                    }
                }) {
                    Image(systemName: "minus")
                        .font(.title2)
                        .frame(width: 35, height: 35)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                Text("\(value)")
                    .font(.title2.bold())
                    .frame(minWidth: 50)
                    #if os(iOS)
                    .sensoryFeedback(.impact, trigger: value)
                    #endif

                Button(action: {
                    if value < range.upperBound {
                        value += 1
                    }
                }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .frame(width: 35, height: 35)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }
}
