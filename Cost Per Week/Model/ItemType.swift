//
//  ItemType.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 11.05.2023.
//

import UIKit
import SwiftUI

enum ItemType: String, CaseIterable, Codable, Identifiable {
    
    static func StringIntoType(string: String) -> Self {
        
        if string.hasPrefix(self.ipad.rawValue) {
            return .ipad
        } else {
            return .undefined
        }
    }
    
    var id: Self { self }
    //    case phone, laptop, headphones, tv, monitor, console, computer, macbook, iphone, airpods, ipad, car, undefined
    
    case macbook, iphone, airpods, ipad
    case phone, laptop, computer, headphones, tv, monitor, console, car
    case tablet, smartwatch, camera, speaker, router, appliance
    case undefined
    
    func localized() -> LocalizedStringKey {
        switch self {
        case .macbook:
            return LocalizedStringKey("Macbook")
        case .iphone:
            return LocalizedStringKey("iPhone")
        case .airpods:
            return LocalizedStringKey("Airpods")
        case .ipad:
            return LocalizedStringKey("iPad")
        case .phone:
            return LocalizedStringKey("phone")
        case .laptop:
            return LocalizedStringKey("Laptop")
        case .computer:
            return LocalizedStringKey("Computer")
        case .headphones:
            return LocalizedStringKey("Headphones")
        case .tv:
            return LocalizedStringKey("TV")
        case .monitor:
            return LocalizedStringKey("Monitor")
        case .console:
            return LocalizedStringKey("Gaming console")
        case .car:
            return LocalizedStringKey("Car")
        case .tablet:
            return LocalizedStringKey("Tablet")
        case .smartwatch:
            return LocalizedStringKey("Smartwatch")
        case .camera:
            return LocalizedStringKey("Camera")
        case .speaker:
            return LocalizedStringKey("Speaker")
        case .router:
            return LocalizedStringKey("Router")
        case .appliance:
            return LocalizedStringKey("Appliance")
        case .undefined:
            return LocalizedStringKey("Undefined")
        }
    }

    
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
        case .tablet:
            return "ipad.homebutton.landscape.badge.play"
        case .smartwatch:
            return "watch.analog"
        case .camera:
            return "camera"
        case .speaker:
            return "hifispeaker"
        case .router:
            return "wifi.router"
        case .appliance:
            return "bubbles.and.sparkles"
        }
    }
    
    static func stringToItemType(productNameString: String) -> ItemType {
        let productNameStringLowercased = productNameString.lowercased()
        
        let categories: [String: ItemType] = [
            "macbook": .macbook,
            "iphone": .iphone,
            "airpods": .airpods,
            "ipad": .ipad
        ]
        
        for (key, value) in categories {
            if productNameStringLowercased.contains(key) {
                return value
            }
        }
        
        let categorizedLists: [ItemType: [String]] = [
            .phone: ["Samsung", "Huawei", "Xiaomi", "OnePlus", "Google", "LG", "Motorola", "Nokia"],
            .laptop: ["Acer", "Microsoft", "MSI", "Samsung", "Sony vaio", "Lenovo", "Dell", "HP", "Asus"],
            .headphones: ["Sony MDR", "Sony WH", "Bose", "Sennheiser", "Beats", "JBL", "Audio-Technica", "AKG", "Skullcandy", "Beyerdynamic", "Jabra"],
            .tv: ["TCL", "Vizio", "Philips", "Hisense", "Sharp", "Sony Bravia", "Samsung", "LG", "Panasonic"],
            .monitor: ["HP", "ASUS", "Samsung", "LG", "Acer", "BenQ", "ViewSonic", "Lenovo", "Dell"],
            .console: ["xbox", "switch", "playstation", "nintendo"],
            .car: ["Toyota", "Honda", "Ford", "Chevrolet", "Volkswagen", "BMW", "Mercedes-Benz", "Audi", "Tesla", "Nissan"],
            .tablet: ["iPad", "Galaxy Tab", "Surface", "Amazon Fire", "Lenovo Tab"],
            .smartwatch: ["Apple Watch", "Galaxy Watch", "Fitbit", "Garmin", "Huawei Watch"],
            .camera: ["Canon", "Nikon", "Sony Alpha", "Fujifilm", "Panasonic Lumix", "GoPro", "Leica"],
            .speaker: ["Sonos", "Bose", "JBL", "Sony", "Harman Kardon", "Marshall", "Klipsch"],
            .router: ["Netgear", "TP-Link", "Asus", "Linksys", "Google Nest", "Eero"],
            .appliance: ["Whirlpool", "Samsung", "LG", "Bosch", "GE", "Frigidaire", "KitchenAid"]
        ]
        
        for (itemType, list) in categorizedLists {
            for item in list {
                if productNameStringLowercased.contains(item.lowercased()) {
                    return itemType
                }
            }
        }
        return .undefined
    }
}
