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
    
    func showTotalCostButton() -> Bool {
        return !items.isEmpty
    }
    
    func viewTitle() -> String {
        return "CPW"
    }
    
    func numberOfRows() -> Int {
        return items.count
    }
    
    func itemForIndexPath(indexpath: IndexPath) -> Item {
        return items[indexpath.row]
    }
    
    mutating func removeItem(at indexpath: IndexPath) {
        items.remove(at: indexpath.row)
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
    
//    mutating func updateItem (item: Item) {
//        guard let index = items.firstIndex(of: item) else {
//            print("did not found an item with this index")
//            return
//        }
//        items[index] = item
//    }
    
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
    
    func genetateDetailItemViewModel() {
        
    }
    
    
    func generateEmptyListView () -> UIView {
        let errorView = UIView()
        errorView.tag = ItemsTableViewController.TagForView.errorView.rawValue
        let roundedView = UIView()
        errorView.addSubview(roundedView)
        roundedView.backgroundColor = .systemBackground
        roundedView.layer.cornerRadius = 10
        roundedView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Add some items"
        errorView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: errorView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            roundedView.widthAnchor.constraint(equalTo: label.widthAnchor, constant: 20),
            roundedView.heightAnchor.constraint(equalTo: label.heightAnchor, constant: 20),
            roundedView.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            roundedView.centerYAnchor.constraint(equalTo: errorView.centerYAnchor)
        ])
        
        errorView.backgroundColor = .secondarySystemBackground
        return errorView
    }
    
    func shouldPresentEmptyListView() -> Bool {
        if items.isEmpty { return true}
        else {return false}
    }
}
