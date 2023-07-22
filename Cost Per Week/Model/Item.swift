//
//  Item.swift
//  Cost Per Week
//
//  Created by Wheatley on 27.10.2021.
//

import Foundation

struct Item: Codable, Hashable {
    
    static let sampleItem = Item(name: "Smasnug", price: 160000, date: Date(), additionalPrice: nil, itemType: .phone)
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var name: String = ""
    var price: Int = 0
    var date: Date
    var additionalPrice: Int?
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
    
    var pricePerDay: Int {
        return self.pricePerWeek / 7
    }
    
    var pricePerWeek: Int {
        get {
            var interval = DateInterval()
            interval.start = date
            interval.end = Date()
            let secondsSincePurchase = interval.duration.rounded()
            let weeksFromPurchase = Int(secondsSincePurchase / 604800)
            let pricePerWeek: Int = {
                guard weeksFromPurchase != 0 else { return price}
                return Int(price / weeksFromPurchase)
            }()
            
            return pricePerWeek
        }
    }
    
    enum pricePerWeekOrDay: String, Identifiable, Codable, CaseIterable {
        var id: Self { self }
        
        case week, day
    }
    
}
