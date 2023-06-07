//
//  ItemType.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 11.05.2023.
//

import UIKit

enum ItemType: String, CaseIterable, Codable {
    case iphone
    case ipad
    
    func image(type: Self) -> UIImage {
        switch self {
        case .iphone:
            return UIImage(systemName: "iphone")!
        case .ipad:
            return UIImage(systemName: "ipad")!
        }
    }
}
