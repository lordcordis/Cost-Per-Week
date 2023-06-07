//
//  LaunchScreen.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 11.05.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Welcome to ItemCostTracker")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            Text("Effortlessly Calculate Your Weekly Expenses")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()
            Button(action: {
                // Add action here
            }) {
                Text("Get Started")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
