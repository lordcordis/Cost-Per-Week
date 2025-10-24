//
//  ItemsTableViewControllerViewModel.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 11.05.2023.
//

import UIKit

final class HomeViewModel: ObservableObject {
    
    let persistency: PersistenceManager
    
    var weekOrDayBool: Bool
    
    init(persistency: PersistenceManager) {
        self.persistency = persistency
        
        weekOrDayBool = UserDefaults.standard.bool(forKey: PersistenceManager.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)

        if let itemsRetrieved = persistency.retreveData() {
            items = itemsRetrieved
        } else {
            items = []
        }
        
        if let currencyString = Currency.currencyString(), let currency = Currency(rawValue: currencyString) {
            self.currency = currency
        } else {
            currency = .dollar
        }
    }
    
    @Published var items: [Item] = []
    
    @Published var settingsSheetPresented: Bool = false
    
    func viewTitle() -> String {
        
        weekOrDayBool = UserDefaults.standard.bool(forKey: PersistenceManager.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)
        
        switch weekOrDayBool {
            
        case true:
            return .home(.costPerWeek)
        case false:
            return .home(.costPerDay)
        }
    }
    
    func deleteItem(item: Item) {
        guard let index = items.firstIndex(of: item) else {return}
        items.remove(at: index)
        persistency.saveData(items: items)
    }
    
    func updateItem (item: Item) {
        
        for (ind, itemInside) in items.enumerated() where itemInside.id == item.id {
                print("items[ind] = item")
                items[ind] = item
        }
    }
    
    func appendItem (item: Item) {
        items.append(item)
    }
    
    func calculateTotalCost() -> Int {
        return items.reduce(0) { partialResult, item in
            partialResult + item.price
        }
    }
    
    func totalCostForSingleWeek() -> Double {
        return items.reduce(0) { partialResult, item in
            partialResult + item.pricePerWeek
        }
    }
    
    func totalCostForSingleDay() -> Double {
        return items.reduce(0) { partialResult, item in
            partialResult + item.pricePerDay
        }
    }
    
    var pricePerWeekOrDayString: String {
        
        switch weekOrDayBool {
            
        case true:
            return "Per week: " + "\(totalCostForSingleWeek())" + " " + "\(UserDefaults.standard.value(forKey: "currency") ?? "RUB")"
        case false:
            return "Per day: " + "\(totalCostForSingleDay())" + " " + "\(UserDefaults.standard.value(forKey: "currency") ?? "RUB")"
        }
    }
    
    func currencyString() -> String {
        return Currency.currencyString() ?? Currency.dollar.rawValue
    }
    
    var totalPriceString: String {
        return "All items: " + "\(calculateTotalCost())" + " " + "\(UserDefaults.standard.value(forKey: "currency") ?? "RUB")"
    }
    
    func pricePerWeekOrDayStringOutput() -> String {
        return pricePerWeekOrDayString
    }
    
    func totalPriceStringOutput() -> String {
        return totalPriceString
    }
    
    func allItems() -> [Item] {
        return items
    }
    
    func isEmpty() -> Bool {
        return items.isEmpty
    }

    private var currency: Currency
    
    func setCurrency(_ currency: Currency) {
        self.currency = currency
    }
    
    func getCurrency() -> Currency {
        return currency
    }
    
    func shouldPresentEmptyListView() -> Bool {
        return items.isEmpty
    }
    
    func currencyStringIntoSystemImageName() -> String {
        return currency.iconName
    }
    
    func fetchData() {
        if let itemsRetrieved = persistency.retreveData() {
            items = itemsRetrieved
        } else {
            items = []
        }
        
        if let currencyString = Currency.currencyString(), let currency = Currency(rawValue: currencyString) {
            self.currency = currency
        } else {
            currency = .dollar
        }
    }
}
