//
//  DetailViewViewModel.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 24.07.2023.
//

import Foundation
import SwiftUI

final class DetailViewModel: ObservableObject {
    
    enum newAddonToggle {
        case newAddon, addNewButton
    }
    
    init(item: Item? = nil, delegate: ItemTableViewDelegate, dismissDelegate: DismissDelegate, systemCurrencyString: String) {
        
        //        initial setup
        
        tintColor = Color(uiColor: UIColor.systemPink)
        systemCurrencyIconString = systemCurrencyString
        self.dismissDelegate = dismissDelegate
        self.delegate = delegate
        
        //        Init is checking if item is new or imported
        
        if let item = item {
            
            //        item is imported
            
            isNewItem = false
            print("imported item: \(item)")
            
            if item.price == 0 {
                itemPurchasePrice = ""
            } else {
                itemPurchasePrice = String(item.price)
            }
            
            itemIsSold = item.isSold
            itemAddonsActive = item.addonsActive
            additionalExpensesEnabled = item.addonsActive
            
            dateSold = item.dateSold
            
            if item.priceSold == 0 {
                priceSold = ""
            } else {
                priceSold = String(item.priceSold)
            }
            
            itemType = item.itemType
            itemName = item.name
            itemDateOfPurchase = item.date
            
            itemAddonsActive = item.addonsActive
            additionalExpensesEnabled = item.addonsActive
            itemAddons = item.addons
            itemID = item.id
            
            
            soldDatesRange = {
                return item.date
                    ...
                Date()
            }()
            
            purchasedDatesRange = {
                return Date.distantPast
                ...
                item.dateSold
            }()
            
        } else {
            
            //            Item is new
            
            isNewItem = true
            itemPurchasePrice = ""
            itemName = ""
            itemIsSold = false
            itemAddonsActive = false
            itemAddons = []
            additionalExpensesEnabled = false
            itemType = .undefined
            itemDateOfPurchase = Date()
            dateSold = Date()
            priceSold = ""
            itemID = UUID().uuidString
            
            soldDatesRange = {
                return Date.distantPast
                ...
                Date()
            }()
            
            purchasedDatesRange = {
                return Date.distantPast
                ...
                Date()
            }()
        }
    }
    
    let isNewItem: Bool
    let tintColor: Color
    let itemID: String
    
    @Published var itemType: ItemType
    @Published var itemName: String
    @Published var itemDateOfPurchase: Date
    @Published var itemPurchasePrice: String
    @Published var itemAddons: [ItemAddon]
    @Published var itemAddonsActive: Bool
    
    @Published var addNewRepairViewIsVisible = false
    @Published var addNewRepairButtonIsVisible = true
    @Published var additionalExpensesEnabled: Bool = false
    @Published var addonsArrayIsChanged: Bool = false
    
    @Published var newAddonToggle: newAddonToggle = .addNewButton
    
//    @Published var itemIsChangedAndNeedsToSave: Bool = false
    
    var delegate: ItemTableViewDelegate?
    var dismissDelegate: DismissDelegate?
    let systemCurrencyIconString: String
    
    @Published var itemIsSold: Bool
    @Published var priceSold: String
    @Published var dateSold: Date
    
    @Published var purchasedDatesRange: ClosedRange<Date>
    @Published var soldDatesRange: ClosedRange<Date>
    
    //    Checking if price string can be converted to int
    
    private func priceIsValid(price: String) -> Bool {
        return Int(price) != nil
    }
    
    
    //    MARK: -- Product Info Methods
    
    func itemNameToType() {
        withAnimation {
            itemType = ItemType.stringToItemType(productNameString: itemName)
        }
    }
    
    func productNameChanged() {
        itemNameToType()
    }
    
    func productPriceChanged() {
        
    }
    
    func productPurchaseDateChanged() {
        generateSoldDateRange()
    }
    
    func productPurchaseTypeChanged() {
        
    }
    
    //      MARK: Additional Expenses Methods
    
    func removeAddon(at indexSet: IndexSet) {
        itemAddons.remove(atOffsets: indexSet)
    }
    
    func addonsArrayChanged() {
        
    }
    
    
    //    MARK: Item Sold Methods
    
    
    func soldItemPriceChanged() {
        
    }
    
    func soldDateChanged() {
        generatePurchasedDateRange()
    }
    
    func soldToggleChanged() {
        
    }
}

extension DetailViewModel {
    
    func generateSoldDateRange() {
        soldDatesRange = {
            itemDateOfPurchase
            ...
            Date()
        }()
    }
    
    func generatePurchasedDateRange() {
        purchasedDatesRange = {
            Date.distantPast
            ...
            dateSold
        }()
    }
    
    func generateItemForExport() -> Item? {
        
        let priceIntOutput: Int
        let priceSoldIntOutput: Int
        
        if let priceInt = Int(itemPurchasePrice) {
            priceIntOutput = priceInt
        } else {
            priceIntOutput = 0
        }
        
        if let priceSoldInt = Int(priceSold) {
            priceSoldIntOutput = priceSoldInt
        } else {
            priceSoldIntOutput = 0
        }
        
        let itemToExport = Item(name: itemName, price: priceIntOutput, date: itemDateOfPurchase, addonsActive: additionalExpensesEnabled, addons: itemAddons, itemType: itemType, id: itemID, isSold: itemIsSold, dateSold: dateSold, priceSold: priceSoldIntOutput)
        
        return itemToExport
    }
    
    func formOnDisappear() {
        save(dismiss: false)
    }
    
    func save(dismiss: Bool) {
        
        guard let itemToExport = generateItemForExport() else {
            print("item for export can not be generated")
            return}
        
        print("itemToExport \(itemToExport)")
        print("isNewItem \(isNewItem)")
        
        switch isNewItem {
            
        case true:
            guard !itemToExport.name.isEmpty, itemToExport.price != 0 else {
                return
            }
            delegate?.addItemToList(item: itemToExport)
            
        case false:
            delegate?.editItem(item: itemToExport)
        }
        
        if dismiss {
            dismissDelegate?.dismiss()
        }
        
    }
}
