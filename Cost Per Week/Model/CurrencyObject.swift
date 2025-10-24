//
//  Currency.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 12.07.2023.
//

import Foundation

enum Currency: String, CaseIterable, Hashable, Identifiable {
    var id: Self { self }
    
    case dollar, euro, ruble, lari, yen, sterling, lira, rupee
    
    static func currencyString() -> String? {
        UserDefaults.standard.string(forKey: PersistenceManager.KeysForUserDefaults.currency.rawValue)
    }

    static func saveCurrencyAsDefault(currency: Currency) {
        UserDefaults.standard.set(currency.rawValue, forKey: PersistenceManager.KeysForUserDefaults.currency.rawValue)
    }
    
    static func selectedCurrency() -> Currency? {
        guard let currencyString = currencyString(),
              let currency = Currency(rawValue: currencyString) else {
            return nil
        }
        
        return currency
    }
    
    var title: String {
        switch self {
        case .dollar:
                .currency(.dollar)
        case .euro:
                .currency(.euro)
        case .ruble:
                .currency(.ruble)
        case .lari:
                .currency(.lari)
        case .yen:
                .currency(.yen)
        case .sterling:
                .currency(.sterling)
        case .lira:
                .currency(.lira)
        case .rupee:
                .currency(.rupee)
        }
    }
    
    var fullTitle: String {
        switch self {
        case .dollar:
                .currency(.dollarFullTitle)
        case .euro:
                .currency(.euroFullTitle)
        case .ruble:
                .currency(.rubleFullTitle)
        case .lari:
                .currency(.lariFullTitle)
        case .yen:
                .currency(.yenFullTitle)
        case .sterling:
                .currency(.sterlingFullTitle)
        case .lira:
                .currency(.liraFullTitle)
        case .rupee:
                .currency(.rupeeFullTitle)
        }
    }
    
    var shortName: String {
        switch self {
        case .dollar:
            "USD"
        case .euro:
            "EUR"
        case .ruble:
            "RUB"
        case .lari:
            "GEL"
        case .yen:
            "JPY"
        case .sterling:
            "GBP"
        case .lira:
            "TRY"
        case .rupee:
            "INR"
        }
    }
    
    var iconName: String {
        switch self {
        case .dollar:
            "dollarsign"
        case .euro:
            "eurosign"
        case .ruble:
            "rublesign"
        case .lari:
            "larisign"
        case .yen:
            "yensign"
        case .sterling:
            "sterlingsign"
        case .lira:
            "turkishlirasign"
        case .rupee:
            "indianrupeesign"
        }
    }
}
