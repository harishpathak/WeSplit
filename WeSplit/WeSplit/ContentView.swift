//
//  ContentView.swift
//  WeSplit
//
//  Created by Harish on 20/12/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var billAmount = 0.0
    @State private var persons = 2
    @State private var tip = 10
    
    @FocusState private var amountFocus: Bool
    
    let tips = [0,5,10,15,20]
    
    var totalPerPerson: Double {
        let peopleCount = Double(persons + 2)
        let amountPerPerson = totalAmountPlusTip / peopleCount
        return amountPerPerson
    }
    
    var totalAmountPlusTip: Double {
        let tipSelection = Double(tip)
        let tipAmount = billAmount * tipSelection / 100
        return tipAmount + billAmount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter amount", value: $billAmount, format: .currency(code: Locale.current.currencyCode ?? "INR"))
                        .keyboardType(.decimalPad)
                        .focused($amountFocus)
                    
                    Picker("Number of persons", selection: $persons) {
                        ForEach (2..<100) {
                            Text("\($0) persons")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tip) {
                        ForEach(tips, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                } header: {
                    Text("How much tip you want to leave ?")
                }
                
                Section {
                    Text(totalAmountPlusTip, format: .currency(code: Locale.current.currencyCode ?? "INR"))
                } header: {
                    Text("Total amount plus tip is")
                }
                
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "INR"))
                } header: {
                    Text("Amount per person is")
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountFocus = false
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
