//
//  Item.swift
//  Cost Per Week
//
//  Created by Wheatley on 27.10.2021.
//

import Foundation

struct Item: Codable {
    
    static let shared = Item(name: "Name", price: 100, date: Date())
    
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
            let minutes = secondsSince / 60
            let hours = minutes / 60
            let days = hours / 24
            let weeks = days/7
            let weeksRounded = Int(weeks.rounded())
            var pricePerWeek: Int {
                switch weeksRounded {
                case 0: return price
                default: return price/weeksRounded
                }
            }
            
            
            return pricePerWeek
        }
    }
    
}
