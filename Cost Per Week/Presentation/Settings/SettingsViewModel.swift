//
//  SettingsViewModel.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 18.08.2023.
//

import Foundation

class SettingsViewModel: ObservableObject {
    
    init(weekOrDay: Bool, delegate: ChangeWeekOrDayInItemsTableViewDelegate?) {
        
        weekOrDayBool = TimePeriod.current()
        
        selectedCurrency = Currency.selectedCurrency() ?? .dollar
    }
    
    weak var delegate: ChangeWeekOrDayInItemsTableViewDelegate?
    
    let currencyAllCases = Currency.allCases
    @Published var weekOrDayBool: TimePeriod
    @Published var selectedCurrency = Currency.dollar
    
    func saveCurrency() {
        Currency.saveCurrencyAsDefault(currency: selectedCurrency)
        delegate?.refreshCurrency(currencyString: selectedCurrency.title)
        delegate?.refreshTitleAndReloadTableView()
    }
    
    func saveDayOrWeek() {
        
        switch weekOrDayBool {
        case .week:
            TimePeriod.saveCurrent(.week)
        case .day:
            TimePeriod.saveCurrent(.day)
        }
    }
    
    func deleteAllData() {
        print("deleteAllData()")
//        let persistency = Persistency()
//        persistency.deleteAllData()
//        delegate?.refreshTitle()
    }
}
