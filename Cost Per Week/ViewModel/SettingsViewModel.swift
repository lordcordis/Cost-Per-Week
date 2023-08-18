//
//  SettingsViewModel.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 18.08.2023.
//

import Foundation

class SettingsViewModel: ObservableObject {
    
    init(weekOrDay: Bool, delegate: ChangeWeekOrDayInItemsTableViewDelegate?) {
        
        self.delegate = delegate
        
        switch weekOrDay {
        case true:
            weekOrDayBool = .week
        case false:
            weekOrDayBool = .day
        }
        
        let currencyString = CurrencyObject.currencyString()
        selectedCurrency = Currency.stringIntoCurrencyObject(currencyString: currencyString)
    }
    
    weak var delegate: ChangeWeekOrDayInItemsTableViewDelegate?
    
    let currencyAllCases = Currency.allCases
    @Published var weekOrDayBool: Item.pricePerWeekOrDay = .week
    @Published var selectedCurrency = Currency.dollar
//    @Published var simpleOrDetailedViewType: ViewType = .simple
    
    func saveCurrency(_ newValue: Currency) {
        CurrencyObject.saveCurrencyAsDefault(currency: newValue.returnCurrency())
        delegate?.refreshCurrency(currencyString: newValue.returnCurrency().currencyString)
        delegate?.refreshTitle()
    }
    
    func saveDayOrWeek(_ newValue: Item.pricePerWeekOrDay) {
        
        switch newValue{
        case .week:
            UserDefaults.standard.set(true, forKey: Persistency.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)
            delegate?.refreshTitle()
        case .day:
            UserDefaults.standard.set(false, forKey: Persistency.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)
            delegate?.refreshTitle()
        }
    }
    
//    enum ViewType: String, CaseIterable, Codable, Identifiable {
//        var id: Self { self }
//
//        case simple, detailed
//    }
}
