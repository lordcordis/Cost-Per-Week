//
//  AppLaunchChecker.swift
//  CostPerWeek
//
//  Created by Роман Коренев on 02.02.26.
//

import Foundation
final class AppLaunchChecker {
    private static let launchesKey = "com.costperweek.launchCount"

    @discardableResult
    static func incrementLaunchCount() -> Int {
        let defaults = UserDefaults.standard
        let current = defaults.integer(forKey: launchesKey)
        let updated = current + 1
        defaults.set(updated, forKey: launchesKey)
        return updated
    }

    static func launchCount() -> Int {
        UserDefaults.standard.integer(forKey: launchesKey)
    }

    static func resetLaunchCount() {
        UserDefaults.standard.removeObject(forKey: launchesKey)
    }
}
