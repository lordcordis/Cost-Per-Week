//
//  Addon.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 12.07.2023.
//

import Foundation

struct ItemAddon: Codable, Equatable {
    let description: String
    let price: Int
    
    static let sampleItemAddon = ItemAddon(description: "Battery", price: 6000)
}
