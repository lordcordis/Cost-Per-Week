//
//  ItemsTableViewControllerViewModel.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 11.05.2023.
//

import UIKit

struct ItemsTableViewControllerViewModel {
    
    let persistency = Persistency()
    
    var weekOrDayBool: Bool
    
    init() {
        weekOrDayBool = UserDefaults.standard.bool(forKey: Persistency.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)

        if let itemsRetrieved = persistency.retreveData() {
            items = itemsRetrieved
        } else {
            items = []
        }
        
        let currencyString = CurrencyObject.currencyString()
        currency = Currency.stringIntoCurrencyObject(currencyString: currencyString)
    }
    
    private var items: [Item] {
        didSet {
            persistency.saveData(items: items)
        }
    }
    
    mutating func viewTitle() -> String {
        
        weekOrDayBool = UserDefaults.standard.bool(forKey: Persistency.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)
        
        switch weekOrDayBool {
            
        case true:
            return "Cost per week"
        case false:
            return "Cost per day"
        }
    }
    
    
    
    mutating func removeItem(item: Item) {
        guard let index = items.firstIndex(of: item) else {return}
        items.remove(at: index)
    }
    
    mutating func updateItem (item: Item) {
        
        print("mutating func updateItem \(item)")
        
        print(item.id)
        
        items.map { item in
            print(item.id)
        }
        
        
        for (ind, itemInside) in items.enumerated() {
            if itemInside.id == item.id {
                print("items[ind] = item")
                items[ind] = item
            }
        }
    }
    
    
    mutating func appendItem (item: Item) {
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
        return CurrencyObject.currencyString()
    }
    
    var totalPriceString: String {
        return "All items: " + "\(calculateTotalCost())" + " " + "\(UserDefaults.standard.value(forKey: "currency") ?? "RUB")"
    }
    
//    func resultString() -> String {
//        guard !items.isEmpty else {return "there are no items"}
//        return String("""
//        \(pricePerWeekOrDayString)\n
//        \(totalPriceString)
//        """)
//    }
    
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
    
    mutating func setCurrency(_ currency: Currency) {
        self.currency = currency
    }
    
    func getCurrency() -> Currency {
        return currency
    }
    
    func shouldPresentEmptyListView() -> Bool {
        if items.isEmpty {return true}
        else {return false}
    }
    
    func currencyStringIntoSystemImageName() -> String {
        
        var output = ""
        
        let currencyString = CurrencyObject.currencyString()
        if let selectedCurrencyFromUserDefaults = Currency.allCases.first(where: {
            currencyY
            in
            currencyY.returnCurrency().currencyString == currencyString
        }) {
            output = selectedCurrencyFromUserDefaults.returnCurrency().imageSystemName
        }
        
        return output
    }
}


