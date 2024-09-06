//
//  Item.swift
//  Cost Per Week
//
//  Created by Wheatley on 27.10.2021.
//

import Foundation
import SwiftUI

struct Item: Codable, Hashable, Identifiable {
    
    static let sampleItem = Item(name: "Smasnug", price: 160000, date: Date(), itemType: .phone)
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var name: String = ""
    var price: Int = 0
    var date: Date
    var addons: [ItemAddon]?
    var itemType: ItemType
    var id = UUID()
    
    var dateAsString: String {
        get {
            let format = DateFormatter()
            format.dateStyle = .medium
            let result = format.string(from: self.date)
            return result
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
    
    
//    var pricePerDay: Int {
//        
//        let daysFromPurchase = Int(secondsFromPurchase / 86400)
//        
//        guard daysFromPurchase != 0 else {
//            return fullPrice
//        }
//        
//        return Int(fullPrice / daysFromPurchase)
//        
//    }
    
    var pricePerDay: Int {
        let daysFromPurchase = max(Int(secondsFromPurchase / 86400), 1)
        return fullPrice / daysFromPurchase
    }
    
    var fullPrice: Int {
        return price + priceOfAddons
    }
    
//    var pricePerWeek: Int {
////        get {
////            var interval = DateInterval()
////            interval.start = date
////            interval.end = Date()
////            let secondsSincePurchase = interval.duration.rounded()
////            let weeksFromPurchase = Int(secondsSincePurchase / 604800)
////            let pricePerWeek: Int = {
////                guard weeksFromPurchase != 0 else { return fullPrice}
////                return Int(fullPrice / weeksFromPurchase)
////            }()
////
////            return pricePerWeek
//        
//        let weeksFromPurchase = Int(secondsFromPurchase / 604800)
//        
//        let pricePerWeek: Int = {
//            guard weeksFromPurchase != 0 else { return fullPrice}
//            return Int(fullPrice / weeksFromPurchase)
//        }()
//        
//        return pricePerWeek
//        
//    }
    
    
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
