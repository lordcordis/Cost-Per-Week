//
//  App.swift
//  CostPerWeek
//
//  Created by Роман Коренев on 18.10.25.
//

import SwiftUI

@main
struct CostPerWeekApp: App {
    var body: some Scene {
        WindowGroup {
            ViewAssembly.buildHomeView()
                .tint(ColorManager.tintColor)
        }
    }
}
