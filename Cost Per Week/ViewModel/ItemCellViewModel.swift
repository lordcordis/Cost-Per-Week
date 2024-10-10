//
//  ItemCellViewModel.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 17.08.2023.
//

import Foundation
import SwiftUI

class ItemCellViewModel {
    
    private let item: Item
    private let currency: Currency
    weak var delegate: ItemTableViewDelegate?
    private let weekOrDayBool: Bool
    
    init(item: Item, delegate: ItemTableViewDelegate?, weekOrDay: Bool) {
        self.item = item
        self.delegate = delegate
        self.weekOrDayBool = weekOrDay
        
        let currencyString = CurrencyObject.currencyString()
        currency = Currency.stringIntoCurrencyObject(currencyString: currencyString)
    }
    
    func dateString() -> String {
        return item.dateAsString
    }
    
    func dateSoldString() -> String {
        if let dateSoldAsString = item.dateSoldAsString {
            return dateSoldAsString
        } else {
            return ""
        }
    }
    
    func timeOwnedInterval() -> String {
        if let amoundOfDaysOwned = item.amoundOfDaysOwned {
            return "\(amoundOfDaysOwned) days"
        } else {
            return ""
        }
    }
    
    func shouldShowSoldData() -> Bool {
        if item.amoundOfDaysOwned != nil && item.dateSoldAsString != nil {
            return true
        } else {
            return false
        }
    }
    
    func weekOrDay() -> Bool {
        return weekOrDayBool
    }
    
    func name() -> String {
        return item.name
    }
    
    func systemImageName() -> String {
        return item.itemType.SystemImageName()
    }
    
    func pricePerDay() -> String {
        return String(item.pricePerDay)
    }

    func pricePerWeek() -> String {
        return String(item.pricePerWeek)
    }
    
    func currencyString() -> String {
        
        let locale = Locale.current
        let amount = weekOrDayBool ? item.pricePerWeek : item.pricePerDay
        
        let formatter = NumberFormatter()
        formatter.locale = locale
        formatter.numberStyle = .currency
        
        
        switch currency {
        case .ruble:
            formatter.currencyCode = "RUR"
        case .dollar:
            formatter.currencyCode = "USD"
        case .euro:
            formatter.currencyCode = "EUR"
        case .lari:
            formatter.currencyCode = "GEL"
        case .yen:
            formatter.currencyCode = "JPY"
        case .sterling:
            formatter.currencyCode = "GBP"
        case .lira:
            formatter.currencyCode = "TRY"
        case .rupee:
            formatter.currencyCode = "INR"
//        default:
//            break
        }
        
//        return formatter.string(from: NSNumber(value: amount)) ?? "\(amount) \(currency.rawValue)"
        return formatter.currencySymbol    }
    
    func rubleString(for amount: Int) -> String {
        let remainder10 = amount % 10
        let remainder100 = amount % 100

        var rubleWord: String

        if remainder100 >= 11 && remainder100 <= 19 {
            rubleWord = "рублей"
        } else {
            switch remainder10 {
            case 1:
                rubleWord = "рубль"
            case 2, 3, 4:
                rubleWord = "рубля"
            default:
                rubleWord = "рублей"
            }
        }

        return "\(rubleWord)"
    }
    
    func dollarString(for amount: Int) -> String {
        let remainder10 = amount % 10
        let remainder100 = amount % 100

        var rubleWord: String

        if remainder100 >= 11 && remainder100 <= 19 {
            rubleWord = "долларов"
        } else {
            switch remainder10 {
            case 1:
                rubleWord = "доллар"
            case 2, 3, 4:
                rubleWord = "доллара"
            default:
                rubleWord = "долларов"
            }
        }

        return "\(rubleWord)"
    }
    
    func deleteCurrentItem() {
        delegate?.deleteItem(item: item)
    }
    
    func rubleStringPerDay() -> String {
        rubleString(for: item.pricePerDay)
    }
    
    func rubleStringPerWeek() -> String {
        rubleString(for: item.pricePerWeek)
    }
}
