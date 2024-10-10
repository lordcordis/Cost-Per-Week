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
    
    func saveCurrency() {
        CurrencyObject.saveCurrencyAsDefault(currency: selectedCurrency.returnCurrency())
        delegate?.refreshCurrency(currencyString: selectedCurrency.returnCurrency().currencyString)
        delegate?.refreshTitleAndReloadTableView()
    }
    
    func saveDayOrWeek() {
        
        switch weekOrDayBool {
        case .week:
            UserDefaults.standard.set(true, forKey: Persistency.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)
            delegate?.refreshTitleAndReloadTableView()
        case .day:
            UserDefaults.standard.set(false, forKey: Persistency.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)
            delegate?.refreshTitleAndReloadTableView()
        }
    }
    
    func deleteAllData() {
        print("deleteAllData()")
//        let persistency = Persistency()
//        persistency.deleteAllData()
//        delegate?.refreshTitle()
    }
}
