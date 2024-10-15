//
//  Item.swift
//  Cost Per Week
//
//  Created by Wheatley on 27.10.2021.
//

import Foundation
import SwiftUI

struct Item: Codable, Hashable, Identifiable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var name: String = ""
    var price: Int = 0
    var date: Date
    var addonsActive: Bool
    var addons: [ItemAddon]
    var itemType: ItemType
    var id: String
    
    var isSold: Bool
    var dateSold: Date
    var priceSold: Int
    
    var dateAsString: String {
        get {
            let format = DateFormatter()
            format.dateStyle = .medium
            let result = format.string(from: self.date)
            return result
        }
    }
    
    var dateSoldAsString: String? {
        get {
            let format = DateFormatter()
            format.dateStyle = .medium
            if isSold == true {
                let result = format.string(from: dateSold)
                return result
            } else {
                return nil
            }
        }
    }
    
    var amoundOfDaysOwnedString: String? {
        get {
            if isSold == true {
                let interval = dateSold.timeIntervalSince(date)
                let days = interval / 86400
                let result = String(Int(days))
                return result
            } else {
                return nil
            }
        }
    }
    
    var amoundOfDaysOwnedInt: Int? {
        get {
            if isSold == true {
                let interval = dateSold.timeIntervalSince(date)
                let days = interval / 86400
                let result = Int(days)
                return result
            } else {
                return nil
            }
        }
    }
    
    var amoundOfWeeksOwnedInt: Int? {
        get {
            if isSold == true {
                let interval = dateSold.timeIntervalSince(date)
                let days = interval / 86400 / 7
                let result = Int(days)
                return result
            } else {
                return nil
            }
        }
    }
    
    var priceOfAddons: Int {
        
        guard addonsActive == true else {
            return 0
        }
        
        var additionalPrice: Int = 0
        
        addons.forEach { addon in
            additionalPrice += addon.price
        }
        
        return additionalPrice
        
    }
    
    private var secondsFromPurchase: TimeInterval {
        var interval = DateInterval()
        interval.start = date
        interval.end = Date()
        let output = interval.duration.rounded()
        return output
    }

    
    var pricePerDay: Double {
        
        if isSold {
            if let amoundOfDaysOwnedInt = amoundOfDaysOwnedInt {
                return Double(fullPrice) / Double(amoundOfDaysOwnedInt)
            } else {
                return 0
            }
        } else {
            let daysFromPurchase = max(Int(secondsFromPurchase / 86400), 1)
            return Double(fullPrice) / Double(daysFromPurchase)
             
        }
        
        
        
    }
    
    var fullPrice: Int {
        
        if isSold == true {
            return price + priceOfAddons - priceSold
        } else {
            return price + priceOfAddons
        }
        
    }
    
    var pricePerWeek: Double {
        
        if isSold {
            if let amoundOfWeeksOwnedInt = amoundOfWeeksOwnedInt {
                return Double(fullPrice) / Double(amoundOfWeeksOwnedInt)
            } else {
                return 0
            }
        } else {
            let weeksFromPurchase = max(Int(secondsFromPurchase / 604800), 1)
            return Double(fullPrice) / Double(weeksFromPurchase)
        }
        
        
    }
    
    enum pricePerWeekOrDay: String, Identifiable, Codable, CaseIterable {
        var id: Self { self }
        
        case week, day
        
        var localizedLabel: LocalizedStringKey {
            switch self {
                
            case .week:
                return "week"
            case .day:
                return "day"
            }
        }
    }
    
    
    
}
