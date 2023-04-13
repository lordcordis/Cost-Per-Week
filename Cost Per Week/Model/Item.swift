//
//  Item.swift
//  Cost Per Week
//
//  Created by Wheatley on 27.10.2021.
//

import Foundation

struct Item: Codable {
    
    var name: String
    var price: Int
    var date: Date
    var additionalPrice: Int?
    
    var dateAsString: String {
        get {
            let format = DateFormatter()
            format.dateStyle = .medium
            let result = format.string(from: self.date)
            return result
        }
    }
    
    var pricePerWeek: Int {
        get {
            var interval = DateInterval()
            interval.start = date
            interval.end = Date()
            let secondsSince = interval.duration.rounded()
            let weeksFromPurchase = Int(secondsSince / 604800)
            let pricePerWeek = Int(price / weeksFromPurchase)
            return pricePerWeek
        }
    }
    
}
