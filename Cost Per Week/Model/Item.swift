//
//  Item.swift
//  Cost Per Week
//
//  Created by Wheatley on 27.10.2021.
//

import Foundation
import SwiftUI

struct SoldInfo: Codable, Equatable {
    var dateSold: Date
    var priceSold: Int
}

struct Item: Codable, Hashable, Identifiable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var name: String = ""
    var price: Int = 0
    var date: Date
//    var addonsActive: Bool
    var addons: [ItemAddon]?
    var itemType: ItemType
    var id = UUID()
    
    var isSold: Bool
    var soldInfo: SoldInfo?
    
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
            if let dateSold = soldInfo?.dateSold, isSold == true {
                let result = format.string(from: dateSold)
                return result
            } else {
                return nil
            }
        }
    }
    
    var amoundOfDaysOwned: String? {
        get {
//            let format = DateFormatter()
//            format.dateStyle = .medium
            if let dateSold = soldInfo?.dateSold, isSold == true {
                let interval = dateSold.timeIntervalSince(date)
                let days = interval / 86400
                let result = String(Int(days))
                return result
            } else {
                return nil
            }
        }
    }
    
    var priceOfAddons: Int {
        
        var additionalPrice: Int = 0
        
        if let addons = addons {
            addons.forEach { addon in
                additionalPrice += addon.price
            }
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

    
    var pricePerDay: Int {
        let daysFromPurchase = max(Int(secondsFromPurchase / 86400), 1)
        return fullPrice / daysFromPurchase
    }
    
    var fullPrice: Int {
        return price + priceOfAddons
    }
    
    var pricePerWeek: Int {
        let weeksFromPurchase = max(Int(secondsFromPurchase / 604800), 1)
        return fullPrice / weeksFromPurchase
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
