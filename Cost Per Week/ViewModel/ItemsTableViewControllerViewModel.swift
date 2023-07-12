//
//  ItemsTableViewControllerViewModel.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 11.05.2023.
//

import UIKit

struct ItemsTableViewControllerViewModel {
    
    let persistency = Persistency()
    
    private var items: [Item] {
        didSet {
            persistency.saveData(items: items)
        }
    }
    
    func viewTitle() -> String {
        return "Cost per week"
    }
    
    
    mutating func removeItemDiff(item: Item) {
        guard let index = items.firstIndex(of: item) else {return}
        items.remove(at: index)
    }
    
    mutating func updateItemDiff (item: Item) {
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
    
    var pricePerWeekString: String {
        return "Per week: " + "\(totalCostForSingleWeek())" + " " + "\(UserDefaults.standard.value(forKey: "currency") ?? "RUB")"
    }
    
    var totalPricePerWeekString: String {
        return "All items: " + "\(calculateTotalCost())" + " " + "\(UserDefaults.standard.value(forKey: "currency") ?? "RUB")"
    }
    
    func resultString() -> String {
        guard !items.isEmpty else {return "there are no items"}
        return String("""
        \(pricePerWeekString)\n
        \(totalPricePerWeekString)
        """)
    }
    
    func allItems() -> [Item] {
        return items
    }
    
    func isEmpty() -> Bool {
        return items.isEmpty
    }
    
    init() {
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
}
