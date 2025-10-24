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
        

        selectedCurrency = Currency.selectedCurrency() ?? .dollar
    }
    
    weak var delegate: ChangeWeekOrDayInItemsTableViewDelegate?
    
    let currencyAllCases = Currency.allCases
    @Published var weekOrDayBool: Item.PriceTimePeriod = .week
    @Published var selectedCurrency = Currency.dollar
//    @Published var simpleOrDetailedViewType: ViewType = .simple
    
    func saveCurrency() {
        Currency.saveCurrencyAsDefault(currency: selectedCurrency)
        delegate?.refreshCurrency(currencyString: selectedCurrency.title)
        delegate?.refreshTitleAndReloadTableView()
    }
    
    func saveDayOrWeek() {
        
        switch weekOrDayBool {
        case .week:
            UserDefaults.standard.set(true, forKey: PersistenceManager.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)
            delegate?.refreshTitleAndReloadTableView()
        case .day:
            UserDefaults.standard.set(false, forKey: PersistenceManager.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)
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
