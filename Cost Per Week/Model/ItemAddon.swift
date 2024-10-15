//
//  Addon.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 12.07.2023.
//

import Foundation

struct ItemAddon: Codable, Equatable, Identifiable {
    
//    static let sampleItemAddon = ItemAddon(description: "Battery", price: 6000)
    
    
    init(description: String, price: Int, id: String) {
        
//        initilalising itemAddon with new id, if it is not provided
        
        self.id = id
        self.description = description
        self.price = price
    }
    
    let id: String
    var description: String
    var price: Int
    
}
