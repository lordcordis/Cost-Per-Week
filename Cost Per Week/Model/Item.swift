//
//  Item.swift
//  Cost Per Week
//
//  Created by Wheatley on 27.10.2021.
//

import Foundation

//class ItemViewModel: Identifiable, ObservableObject {
//    
//    init(item: Item) {
//        self.name = item.name
//        self.price = String(item.price)
//        self.id = item.id
//    }
//    
//    @Published var name: String
//    @Published var price: String
//    var id: UUID
//    
//}

struct Item: Codable, Hashable {
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var name: String = ""
    var price: Int = 0
    var date: Date
    var additionalPrice: Int?
    var itemType: ItemType?
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
    
}
