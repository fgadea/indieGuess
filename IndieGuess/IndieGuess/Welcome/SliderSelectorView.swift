//
//  SliderSelectorView.swift
//  IndieGuess
//
//  Created by FELIPE GADEA LLOPIS on 21.6.2025.
//

import SwiftUI

struct SliderSelectorView: View {
    @Binding var value: Double
    var bounds: ClosedRange<Double>


    var body: some View {
        VStack {
            Slider(
                value: $value,
                in: 0...100,
                step: 1
            ) {
                Text("Speed")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("100")
            }
            
            Text("\(Int(value))")
                .font(.title2)
                .fontWeight(.bold)
        }
    }
}
