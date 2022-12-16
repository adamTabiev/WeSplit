//
//  ContentView.swift
//  WeSplit
//
//  Created by Адам Табиев on 15.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0 // общая сумма чека
    @State private var numberOfPeople = 2 // колличество людей
    @State private var tipPercentage = 10 // процент чаевых
    @FocusState private var amountIsFocused: Bool
    
    // MARK: вычисляемое свойство: общая сумма вместе с чаевыми с человека.
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2) // количество людей
        let tipSelection = Double(tipPercentage)     // процент чаевых
        
        let tipValue = checkAmount / 100 * tipSelection  // общая сумма оставляемых чаевых
        let grandTotal = checkAmount + tipValue          // общий счёт вместе с чаевыми
        let amountPerPerson = grandTotal / peopleCount    // конечная сумма с человека вместе с чаевыми
        
        return amountPerPerson // конечная сумма с человека вместе с чаевыми
    }
    
    // MARK: вычисляемое свойство: общая сумма со всех вместе с чаевыми.
    var grandTotalSum: Double {
        let tipSelection = Double(tipPercentage)     // процент чаевых
        let tipValue = checkAmount / 100 * tipSelection  // общая сумма оставляемых чаевых
        let grandTotalSum = checkAmount + tipValue          // общий счёт вместе с чаевыми
        
        return grandTotalSum // возращаем общую сумму со всех вместе с чаевыми
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
//                Section {
//                    Picker("Tip percentage", selection: $tipPercentage) {
//                        ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                } header: {
//                    Text("How much tip do you want to leave")
//                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Check amount")
                }
                
                Section {
                    Text(grandTotalSum, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("total Amount")
                }
                
                
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
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
