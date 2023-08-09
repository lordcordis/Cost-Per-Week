//
//  Currency.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 12.07.2023.
//

import Foundation

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
    let imageSystamName: String
}

enum Currency: String, CaseIterable, Hashable, Identifiable {
    var id: String { self.returnCurrency().currencyString }
    
    case dollar, euro, ruble, lari, yen, sterling, lira, rupee
    
    func returnCurrency() -> CurrencyObject {
        switch self {
        case .dollar:
            return CurrencyObject(currencyFullTitle: "US Dollar", currencyString: "USD", imageSystamName: "dollarsign")
        case .euro:
            return CurrencyObject(currencyFullTitle: "Euro", currencyString: "EUR", imageSystamName: "eurosign")
        case .ruble:
            return CurrencyObject(currencyFullTitle: "Russian Ruble", currencyString: "RUR", imageSystamName: "rublesign")
        case .lari:
            return CurrencyObject(currencyFullTitle: "Georgian Lari", currencyString: "GEL", imageSystamName: "larisign")
        case .yen:
            return CurrencyObject(currencyFullTitle: "Japanese Yen", currencyString: "JPY", imageSystamName: "yensign")
        case .sterling:
            return CurrencyObject(currencyFullTitle: "United Kingdom Sterling", currencyString: "GBP", imageSystamName: "sterlingsign")
        case .lira:
            return CurrencyObject(currencyFullTitle: "Turkish Lira", currencyString: "TRY", imageSystamName: "turkishlirasign")
        case .rupee:
            return CurrencyObject(currencyFullTitle: "Indian Rupee", currencyString: "INR", imageSystamName: "indianrupeesign")
        }
    }
}
