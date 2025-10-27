//
//  WeekDayManager.swift
//  CostPerWeek
//
//  Created by Роман Коренев on 19.10.25.
//

import Foundation

enum TimePeriod: Identifiable, CaseIterable {
    
    var id: Self { self }
    
    case week, day
    
    var title: String {
        switch self {
        case .week:
            return .home(.costPerWeek)
        case .day:
            return .home(.costPerDay)
        }
    }
    
    static func current() -> TimePeriod {
        let weekOrDayBool = UserDefaults.standard.bool(forKey: PersistenceManager.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)
        
        switch weekOrDayBool {
        case true: return .week
        case false: return .day
        }
    }
    
    static func saveCurrent(_ period: TimePeriod) {
        UserDefaults.standard.set(period == .week, forKey: PersistenceManager.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)
    }
}
