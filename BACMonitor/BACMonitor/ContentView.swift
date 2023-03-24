//
//  ContentView.swift
//  BACMonitor
//
//  Created by Roy Quesada on 23/3/23.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    @State private var bacInput: String = ""
    @State private var lastestBAC: Double = 0.0
    @ObservedObject private var healthStore = HealthStore()
    
    
    var body: some View {
        VStack {
            TextField("Enter your BAC", text: $bacInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
                .padding()
            
            Button("Submit BAC"){
                if let bacValue = Double(bacInput){
                    healthStore.addBACData(bacValue: bacValue)
                    bacInput = ""
                }
            }
            .padding()
            
            Text("Lastest BAC: \(lastestBAC, specifier: "%,3f")")
                .padding()
        }
        
        .onAppear{
            healthStore.getLastestBAC { result in
                lastestBAC = result
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
