//
//  Currency.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 12.07.2023.
//

import Foundation
import SwiftUI

struct CurrencyObject: Hashable, Identifiable, Equatable {
    
//    Saving currency in userDefaults
    
    static func saveCurrencyAsDefault(currency: CurrencyObject) {
        UserDefaults.standard.setValue(NSString(string: currency.currencyString), forKey: Persistency.KeysForUserDefaults.currency.rawValue)
    }
    
//    Getting currency string from userDefaults, returning "USD" if not present
    
    static func currencyString() -> String {
        return "\(UserDefaults.standard.value(forKey: Persistency.KeysForUserDefaults.currency.rawValue) ?? "USD")"
    }
    
    var id: String { self.currencyString }
    
    let currencyFullTitle: String
    let currencyString: String
    let imageSystemName: String
}

enum Currency: String, CaseIterable, Hashable, Identifiable {
    var id: String { self.returnCurrency().currencyString }
    
    case dollar, euro, ruble, lari, yen, sterling, lira, rupee
    
    static func stringIntoCurrencyObject(currencyString: String) -> Currency {
        
        if let selectedCurrencyFromUserDefaults = Currency.allCases.first(where: { currencyY in
            currencyY.returnCurrency().currencyString == currencyString
        }) {
            return selectedCurrencyFromUserDefaults
        } else {
            return Currency.dollar
        }
    }
    
    func returnCurrency() -> CurrencyObject {
        switch self {
        case .dollar:
            return CurrencyObject(currencyFullTitle: "US Dollar", currencyString: "USD", imageSystemName: "dollarsign")
        case .euro:
            return CurrencyObject(currencyFullTitle: "Euro", currencyString: "EUR", imageSystemName: "eurosign")
        case .ruble:
            return CurrencyObject(currencyFullTitle: "Russian Ruble", currencyString: "RUR", imageSystemName: "rublesign")
        case .lari:
            return CurrencyObject(currencyFullTitle: "Georgian Lari", currencyString: "GEL", imageSystemName: "larisign")
        case .yen:
            return CurrencyObject(currencyFullTitle: "Japanese Yen", currencyString: "JPY", imageSystemName: "yensign")
        case .sterling:
            return CurrencyObject(currencyFullTitle: "United Kingdom Sterling", currencyString: "GBP", imageSystemName: "sterlingsign")
        case .lira:
            return CurrencyObject(currencyFullTitle: "Turkish Lira", currencyString: "TRY", imageSystemName: "turkishlirasign")
        case .rupee:
            return CurrencyObject(currencyFullTitle: "Indian Rupee", currencyString: "INR", imageSystemName: "indianrupeesign")
        }
    }
    
    var localized: LocalizedStringKey {
        switch self {
            
        case .dollar:
            "dollar"
        case .euro:
            "euro"
        case .ruble:
            "ruble"
        case .lari:
            "lari"
        case .yen:
            "yen"
        case .sterling:
            "sterling"
        case .lira:
            "lira"
        case .rupee:
            "rupee"
        }
    }
}
