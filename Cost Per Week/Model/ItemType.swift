//
//  ItemType.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 11.05.2023.
//

import UIKit

enum ItemType: String, CaseIterable, Codable, Identifiable {
    
    static func StringIntoType(string: String) -> Self {
        
        if string.hasPrefix(self.ipad.rawValue) {
            return .ipad
        } else {
            return .undefined
        }
    }
    
    var id: Self { self }
    case phone, laptop, headphones, tv, monitor, console, computer, macbook, iphone, airpods, ipad, car, undefined
    
    func description() -> String {
        switch self {
        case .tv:
            return "TV"
        case .console:
            return "Gaming console"
        case .iphone:
            return "iPhone"
        case .airpods:
            return "AirPods"
        case .ipad:
            return "iPad"
        case .macbook:
            return "MacBook"
        default:
            return self.rawValue.capitalized
        }
    }
    
    func SystemImageName() -> String {
        switch self {
        case .phone:
            return "candybarphone"
        case .laptop:
            return "laptopcomputer"
        case .headphones:
            return "headphones"
        case .tv:
            return "tv"
        case .console:
            return "gamecontroller"
        case .iphone:
            return "iphone"
        case .airpods:
            return "airpods"
        case .monitor:
            return "display"
        case .computer:
            return "desktopcomputer"
        case .macbook:
            return "laptopcomputer"
        case .ipad:
            return "ipad"
        case .car:
            return "car"
        case .undefined:
            return "ellipsis"
        }
    }
    
    static func stringToItemType(productNameString: String) -> ItemType {
        
//        phone, laptop, headphones, tv, monitor, console, computer, macbook, iphone, airpods, ipad, car
        
        
        let productNameStringLoweracased = productNameString.lowercased()
        var output = ItemType.undefined
    
//        phone
        
        let phoneList = ["galaxy", "xiaomi", "oneplus", "oppo"]
        
        for itemName in phoneList {
            if productNameStringLoweracased.contains(itemName) {
                output = .phone
            }
        }
        
//        laptop
        
        let laptopList = ["lenovo"]
        
        for itemName in laptopList {
            if productNameStringLoweracased.contains(itemName) {
                output = .headphones
            }
        }
        
        
//        headphones
        
        let headphonesList = ["sennheiser", "beats", "audiotechnica"]
        
        for itemName in headphonesList {
            if productNameStringLoweracased.contains(itemName) {
                output = .headphones
            }
        }
        
//        tv
        
//        monitor
        
        let monitorList = ["viewsonic", "acer", "asus", "aoc, "]
        
        for itemName in monitorList {
            if productNameStringLoweracased.contains(itemName) {
                output = .monitor
            }
        }
        
//        console
        
        let consolesList = ["xbox", "switch", "playstation", "nintendo"]
        
        for itemName in consolesList {
            if productNameStringLoweracased.contains(itemName) {
                output = .console
            }
        }
        
//        computer
        
//        macbook
        
        if productNameStringLoweracased.contains("macbook") {
            output = .macbook
        }
        
//        iphone
        
        if productNameStringLoweracased.contains("iphone") {
            output = .iphone
        }
        
//        airpods
        
        if productNameStringLoweracased.contains("airpods") {
            output = .airpods
        }
        
//        ipad
        
        if productNameStringLoweracased.contains("ipad") {
            output = .ipad
        }
        
//        car
        
        let carsList = ["toyota", "nissan", "ford", "honda", "bmw"]
        
        for itemName in carsList {
            if productNameStringLoweracased.contains(itemName) {
                output = .car
            }
        }

        return output
    }
}
