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
    
    case macbook, iphone, airpods, ipad, appleWatch
    case phone, laptop, computer, headphones, tv, monitor, console, car
    case tablet, smartwatch, camera, speaker, router, appliance
    case musicInstrument
    case undefined
    
    func localized() -> LocalizedStringKey {
        switch self {
        case .macbook:
            return LocalizedStringKey("Macbook")
        case .iphone:
            return LocalizedStringKey("iPhone")
        case .appleWatch:
            return LocalizedStringKey("Apple Watch")
        case .airpods:
            return LocalizedStringKey("AirPods")
        case .ipad:
            return LocalizedStringKey("iPad")
        case .phone:
            return LocalizedStringKey("Smartphone")
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
        case .musicInstrument:
            return LocalizedStringKey("Music Instrument")
        case .undefined:
            return LocalizedStringKey("")
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
            return "smartphone"
        case .appleWatch:
            return "applewatch"
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
        case .musicInstrument:
            return "guitars"
        }
    }
    
    static func stringToItemType(productNameString: String) -> ItemType {
        let productNameStringLowercased = productNameString.lowercased()
        
        let categories: [String: ItemType] = [
            "macbook": .macbook,
            "iphone": .iphone,
            "airpods": .airpods,
            "ipad": .ipad,
            "apple watch": .appleWatch
            
        ]
        
        for (key, value) in categories where productNameStringLowercased.contains(key) {
            return value
        }
        
        let categorizedLists: [ItemType: [String]] = [
            .phone: ["samsung", "huawei", "xiaomi", "oneplus", "google", "lg", "motorola", "nokia"],
            .laptop: ["acer", "microsoft", "msi", "samsung", "sony vaio", "lenovo", "dell", "hp", "asus"],
            .headphones: ["sony mdr", "sony wh", "bose", "sennheiser", "beats", "jbl", "audio-technica", "akg", "skullcandy", "beyerdynamic", "jabra"],
            .tv: ["tcl", "vizio", "philips", "hisense", "sharp", "sony bravia", "samsung", "lg", "panasonic"],
            .monitor: ["hp", "asus", "samsung", "lg", "acer", "benq", "viewsonic", "lenovo", "dell"],
            .console: ["xbox", "switch", "playstation", "nintendo"],
            .car: ["toyota", "honda", "ford", "chevrolet", "volkswagen", "bmw", "mercedes-benz", "audi", "tesla", "nissan"],
            .tablet: ["ipad", "galaxy tab", "surface", "amazon fire", "lenovo tab"],
            .smartwatch: ["apple watch", "galaxy watch", "fitbit", "garmin", "huawei watch"],
            .camera: ["canon", "nikon", "sony alpha", "fujifilm", "panasonic lumix", "gopro", "leica"],
            .speaker: ["sonos", "bose", "jbl", "sony", "harman kardon", "marshall", "klipsch"],
            .router: ["netgear", "tp-link", "asus", "linksys", "google nest", "eero"],
            .appliance: ["whirlpool", "samsung", "lg", "bosch", "ge", "frigidaire", "kitchenaid"],
            .musicInstrument: ["gibson", "fender", "yamaha", "ibanez", "roland", "korg", "casio", "steinway", "pearl", "dw drums"]
        ]

        for (itemType, list) in categorizedLists {
            for item in list where productNameStringLowercased.contains(item) {
                return itemType
            }
        }
        return .undefined
    }
}
