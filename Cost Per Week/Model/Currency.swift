//
//  Currency.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 12.07.2023.
//

import Foundation

struct Currency: Hashable, Identifiable, Equatable {
    
    static func saveCurrencyAsDefault(currency: Currency) {
        UserDefaults.standard.setValue(NSString(string: currency.currencyString), forKey: Persistency.KeysForUserDefaults.currency.rawValue)
    }
    
    static func currencyString() -> String {
        return "\(UserDefaults.standard.value(forKey: Persistency.KeysForUserDefaults.currency.rawValue) ?? "USD")"
    }
    
    var id: String { self.currencyString }
    
    let currencyFullTitle: String
    let currencyString: String
    let imageSystamName: String
    
    static let currencyList = [Currency(currencyFullTitle: "US Dollar", currencyString: "USD", imageSystamName: "dollarsign"),
                               Currency(currencyFullTitle: "Euro", currencyString: "EUR", imageSystamName: "eurosign"),
                               Currency(currencyFullTitle: "Russian Ruble", currencyString: "RUR", imageSystamName: "rublesign"),
                               Currency(currencyFullTitle: "Georgian Lari", currencyString: "GEL", imageSystamName: "larisign"),
                               Currency(currencyFullTitle: "Japanese Yen", currencyString: "JPY", imageSystamName: "yensign"),
                               Currency(currencyFullTitle: "United Kingdom Sterling", currencyString: "GBP", imageSystamName: "sterlingsign"),
                               Currency(currencyFullTitle: "Turkish Lira", currencyString: "TRY", imageSystamName: "turkishlirasign"),
                               Currency(currencyFullTitle: "Indian Rupee", currencyString: "INR", imageSystamName: "indianrupeesign")]
}

enum CurrencyList: String, CaseIterable, Hashable, Identifiable {
    var id: String { self.returnCurrency().currencyString }
    
    case dollar, euro, ruble, lari, yen, sterling, lira, rupee
    
    
    func returnCurrency() -> Currency {
        switch self {
        case .dollar:
            return Currency(currencyFullTitle: "US Dollar", currencyString: "USD", imageSystamName: "dollarsign")
        case .euro:
            return Currency(currencyFullTitle: "Euro", currencyString: "EUR", imageSystamName: "eurosign")
        case .ruble:
            return Currency(currencyFullTitle: "Russian Ruble", currencyString: "RUR", imageSystamName: "rublesign")
        case .lari:
            return Currency(currencyFullTitle: "Georgian Lari", currencyString: "GEL", imageSystamName: "larisign")
        case .yen:
            return Currency(currencyFullTitle: "Japanese Yen", currencyString: "JPY", imageSystamName: "yensign")
        case .sterling:
            return Currency(currencyFullTitle: "United Kingdom Sterling", currencyString: "GBP", imageSystamName: "sterlingsign")
        case .lira:
            return Currency(currencyFullTitle: "Turkish Lira", currencyString: "TRY", imageSystamName: "turkishlirasign")
        case .rupee:
            return Currency(currencyFullTitle: "Indian Rupee", currencyString: "INR", imageSystamName: "indianrupeesign")
        }
    }
}
