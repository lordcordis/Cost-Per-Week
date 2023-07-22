//
//  ItemsTableViewControllerViewModel.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 11.05.2023.
//

import UIKit

struct ItemsTableViewControllerViewModel {
    
    let persistency = Persistency()
    
    var weekOrDayBool: Bool {
        didSet{
            print(weekOrDayBool)
        }
    }
    
//    var currency = Currency.getCurrency
    
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
        
        
        
//        return "Cost per week"
    }
    
    
    
    mutating func removeItem(item: Item) {
        guard let index = items.firstIndex(of: item) else {return}
        items.remove(at: index)
    }
    
    mutating func updateItem (item: Item) {
        for (ind, itemInside) in items.enumerated() {
            if itemInside.id == item.id {
                print("updateItemDiff success")
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
    
    func totalCostForSingleWeek() -> Int {
        return items.reduce(0) { partialResult, item in
            partialResult + item.pricePerWeek
        }
    }
    
    func totalCostForSingleDay() -> Int {
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
    
    var totalPriceString: String {
        return "All items: " + "\(calculateTotalCost())" + " " + "\(UserDefaults.standard.value(forKey: "currency") ?? "RUB")"
    }
    
    func resultString() -> String {
        guard !items.isEmpty else {return "there are no items"}
        return String("""
        \(pricePerWeekOrDayString)\n
        \(totalPriceString)
        """)
    }
    
    func allItems() -> [Item] {
        return items
    }
    
    func isEmpty() -> Bool {
        return items.isEmpty
    }
    
    init() {
        weekOrDayBool = UserDefaults.standard.bool(forKey: Persistency.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)

        if let itemsRetrieved = persistency.retreveData() {
            items = itemsRetrieved
        } else {
            items = []
        }
    }
    
    func shouldPresentEmptyListView() -> Bool {
        if items.isEmpty {return true}
        else {return false}
    }
    
    func currencyStringIntoSystemImageName() -> String {
        
        var output = ""
        
        let currencyString = Currency.currencyString()
        if let selectedCurrencyFromUserDefaults = CurrencyList.allCases.first(where: {
            currencyY
            in
            currencyY.returnCurrency().currencyString == currencyString
        }) {
            output = selectedCurrencyFromUserDefaults.returnCurrency().imageSystamName
        }
        
        return output
    }
}
