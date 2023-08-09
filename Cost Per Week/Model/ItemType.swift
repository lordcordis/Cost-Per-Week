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
        let productNameStringLowercased = productNameString.lowercased()
        
        if productNameStringLowercased.contains("macbook") {
            return .macbook
        } else if productNameStringLowercased.contains("iphone") {
            return .iphone
        } else if productNameStringLowercased.contains("airpods") {
            return .airpods
        } else if productNameStringLowercased.contains("ipad") {
            return .ipad
        }
        
        let phoneList = ["Samsung", "Huawei", "Xiaomi", "OnePlus", "Google", "LG", "Motorola", "Nokia"]
        let laptopList = ["Acer", "Microsoft", "MSI", "Samsung", "Sony vaio",
                          "Lenovo ThinkPad",
                          "Lenovo IdeaPad",
                          "Lenovo Yoga",
                          "Lenovo Legion",
                          "Lenovo Flex",
                          "Lenovo Chromebook",
                          "Lenovo V Series",
                          "Lenovo ThinkBook",
                          "Lenovo Miix",
                          "Dell Inspiron",
                          "Dell XPS",
                          "Dell Vostro",
                          "Dell Latitude",
                          "Dell Precision",
                          "Dell G Series",
                          "Dell Alienware",
                          "Dell Chromebook",
                          "Dell Studio",
                          "Dell Studio XPS",
                          "Dell Adamo",
                          "Dell Venue",
                          "Dell XPS",
                          "HP Spectre",
                          "HP ENVY",
                          "HP Pavilion",
                          "HP EliteBook",
                          "HP ProBook",
                          "HP ZBook",
                          "HP Omen",
                          "HP Chromebook",
                          "HP Stream",
                          "HP Essential",
                          "Asus ZenBook",
                          "Asus VivoBook",
                          "Asus ROG",
                          "Asus TUF Gaming",
                          "Asus Chromebook",
                          "Asus Transformer Book",
                          "Asus ProArt StudioBook",
                          "Asus ExpertBook"
        ]
        let headphonesList = ["Sony MDR", "Sony WH", "Bose", "Sennheiser", "Beats", "JBL", "Audio-Technica", "AKG", "Skullcandy", "Beyerdynamic", "Jabra"]
        let tvList = ["TCL", "Vizio", "Philips", "Hisense", "Sharp", "Sony Bravia"]
        let monitorList = ["HP", "ASUS", "Samsung", "LG", "Acer", "BenQ", "ViewSonic", "Lenovo",
                           "Dell UltraSharp",
                           "Dell P Series",
                           "Dell Alienware",
                           "Dell S Series",
                           "Dell U Series",
                           "Dell E Series",
                           "Dell SE Series",
                           "Dell Gaming",
                           "Dell Professional",
                           "Dell Ultrathin",
                           "Dell Curved",
                           "Dell Touch",
                           "Dell HDR",
                           "Dell InfinityEdge"
        ]
        let consolesList = ["xbox", "switch", "playstation", "nintendo"]
        let carsList = ["Toyota", "Honda", "Ford", "Chevrolet", "Volkswagen", "BMW", "Mercedes-Benz", "Audi", "Tesla", "Nissan"]
        
        let finalList = [phoneList, laptopList, headphonesList, tvList, monitorList, consolesList, carsList]
        
        for list in finalList {
            for item in list {
                if productNameStringLowercased.contains(item.lowercased()) {
                    switch list {
                    case phoneList: return .phone
                    case laptopList: return .laptop
                    case headphonesList: return .headphones
                    case tvList: return .tv
                    case monitorList: return .monitor
                    case consolesList: return .console
                    case carsList: return .car
                    default:
                        break
                    }
                }
            }
        }
        
        return .undefined
    }
}
