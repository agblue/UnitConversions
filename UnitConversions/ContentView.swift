//
//  ContentView.swift
//  UnitConversions
//
//  Created by Danny Tsang on 9/6/23.
//

import SwiftUI

enum TimeUnit: String {
    case seconds = "Seconds"
    case minutes = "Minutes"
    case hours = "Hours"
    case days = "Days"
}

struct ContentView: View {
    @State private var inputUnit: TimeUnit = .seconds
    @State private var outputUnit: TimeUnit = .seconds
    @State private var inputAmount = 0.00

    @FocusState private var isAmountFocused: Bool

    private var outputAmount: Double {
        var inputBase = Double(inputAmount)
        switch inputUnit {
        case .seconds:
            break
        case .minutes:
            inputBase = inputBase * 60
        case .hours:
            inputBase = inputBase * 60 * 60
        case .days:
            inputBase = inputBase * 24 * 60 * 60
        }

        var outputBase = inputBase
        switch outputUnit {
        case .seconds:
            break
        case .minutes:
            outputBase = outputBase / 60
        case .hours:
            outputBase = outputBase / 60 / 60
        case .days:
            outputBase = outputBase / 24 / 60 / 60
        }

        return outputBase
    }

    let timeUnits: [TimeUnit] = [.seconds, .minutes, .hours, .days]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Input Unit", selection: $inputUnit) {
                        ForEach(timeUnits, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input Unit")
                }

                Section {
                    Picker("Output Unit", selection: $outputUnit) {
                        ForEach(timeUnits, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Output Unit")
                }

                Section {
                    TextField("Input Amount", value: $inputAmount, format: .number)
                        .keyboardType(.numberPad)
                        .focused($isAmountFocused)
                } header: {
                    Text("Input \(inputUnit.rawValue)")
                }

                Section {
                    Text("\(outputAmount, format: .number) \(outputUnit.rawValue)")
                } header: {
                    Text("Output Result")
                }
            }
            .navigationTitle("Unit Conversions")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isAmountFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
