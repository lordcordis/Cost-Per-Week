//
//  DetailViewViewModel.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 24.07.2023.
//

import Foundation
import SwiftUI

final class DetailViewModel: ObservableObject {
    
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
            additionalExpensesSectionIsVisible = item.addonsActive
            
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
            additionalExpensesSectionIsVisible = item.addonsActive
            itemAddons = item.addons ?? []
            itemID = item.id
            
        } else {
            
            //            Item is new
            
            isNewItem = true
            itemPurchasePrice = ""
            itemName = ""
            itemIsSold = false
            itemAddonsActive = false
            itemAddons = []
            additionalExpensesSectionIsVisible = false
            itemType = .undefined
            itemDateOfPurchase = Date()
            dateSold = Date()
            priceSold = ""
            itemID = UUID().uuidString
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
    @Published var additionalExpensesSectionIsVisible: Bool = false
    @Published var addonsArrayIsChanged: Bool = false
    
//    @Published var itemIsChangedAndNeedsToSave: Bool = false
    
    var delegate: ItemTableViewDelegate?
    var dismissDelegate: DismissDelegate?
    let systemCurrencyIconString: String
    
    @Published var itemIsSold: Bool
    @Published var priceSold: String
    @Published var dateSold: Date
    
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
        
    }
    
    func soldToggleChanged() {
        
    }
}

extension DetailViewModel {
    
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
        
        let itemToExport = Item(name: itemName, price: priceIntOutput, date: itemDateOfPurchase, addonsActive: additionalExpensesSectionIsVisible, addons: itemAddons, itemType: itemType, id: itemID, isSold: itemIsSold, dateSold: dateSold, priceSold: priceSoldIntOutput)
        
        return itemToExport
    }
    
    func formOnDisappear() {
//        save(dismiss: false)
    }
    
    func save(dismiss: Bool) {
        
        guard let itemToExport = generateItemForExport() else {
            print("item for export can not be generated")
            return}
        
        print("itemToExport \(itemToExport)")
        print("isNewItem \(isNewItem)")
        
        switch isNewItem {
            
        case true:
            delegate?.addItemToList(item: itemToExport)
            
        case false:
            delegate?.editItem(item: itemToExport)
        }
        
        if dismiss {
            dismissDelegate?.dismiss()
        }
        
    }
}



//    checking if immutable initialItem is different to current state of item based on name, price, dateOfPurchase, itemType, addons

//    private func checkIfItemChangedAndSave() {
//
//        guard let priceInt = Int(price), let priceSoldInt = Int(priceSold) else {return}
//
//        let itemToExport = Item(name: itemName, price: priceInt, date: itemDateOfPurchase, addonsActive: addonsActive, addons: itemAddons, itemType: itemType, id: initialItem.id, isSold: itemIsSold, dateSold: soldDate, priceSold: priceSoldInt)
//
//
//        if itemToExport != initialItem {
//            print("item did change, saving")
//            saveItem()
//        }
//
//
//    }


//    saving item based on isNewItem property

//    func saveItem() {
//        guard priceIsValid(price: price) else {
//            print("price is invalid")
//            return }
//
//        switch isNewItem {
//
//        case true:
//
//            guard !itemName.isEmpty, !price.isEmpty else {
//                print("new item can not be exported, !name.isEmpty, !price.isEmpty")
//                return
//            }
//
//            var itemToExport: Item
//
////            generateSoldInfo()
//            itemToExport = Item(name: itemName, price: Int(price)!, date: itemDateOfPurchase, addonsActive: addonsActive, addons: itemAddons, itemType: itemType,isSold: itemIsSold, dateSold: soldDate, priceSold: Int(priceSold)!)
//
//            print(String.init(describing: itemToExport))
//
//            if isNewItemCreated == false {
//                print("isNewItemCreated == false")
//                delegate?.addItemToList(item: itemToExport)
//                isNewItemCreated = true
//            } else {
//                delegate?.editItem(item: itemToExport)
//            }
//
//
//        case false:
//
//            var itemToExport: Item
//
//            //            if let soldInfo = self.soldInfo {
//            //                itemToExport = Item(name: name, price: Int(price)!, date: dateOfPurchase, addons: addons, itemType: itemType, id: initialItem.id, isSold: isSold, soldInfo: soldInfo)
//            //            } else {
////            generateSoldInfo()
//            itemToExport = Item(name: itemName, price: Int(price)!, date: itemDateOfPurchase, addonsActive: addonsActive, addons: itemAddons, itemType: itemType, id: initialItem.id, isSold: itemIsSold, dateSold: soldDate, priceSold: Int(priceSold)!)
//            //            }
//
//            delegate?.editItem(item: itemToExport)
//        }
//    }

//    func saveItemAndDismiss() {
//        guard priceIsValid(price: price) else {
//            print("price is invalid")
//            return }
//
//        switch isNewItem {
//        case true:
//            guard !name.isEmpty, !price.isEmpty else {
//                print("item can not be exported")
//                return
//            }
//
//            var itemToExport: Item
//
//
//            itemToExport = Item(name: name, price: Int(price)!, date: dateOfPurchase, addonsActive: addonsActive, addons: addons, itemType: itemType, isSold: isSold, soldInfo: soldInfo)
//
//
//
//            delegate?.addItemToList(item: itemToExport)
//
//
//        case false:
//
//            var itemToExport: Item
//
//            if let soldInfo = self.soldInfo {
//                itemToExport = Item(name: name, price: Int(price)!, date: dateOfPurchase, addonsActive: addonsActive, addons: addons, itemType: itemType, id: initialItem.id, isSold: self.isSold, soldInfo: soldInfo)
//            } else {
//                itemToExport = Item(name: name, price: Int(price)!, date: dateOfPurchase, addonsActive: addonsActive, addons: addons, itemType: itemType, id: initialItem.id, isSold: self.isSold)
//            }
//
//            delegate?.editItem(item: itemToExport)
//        }
//
//
//
//        dismissDelegate?.dismiss()
//    }

//    checking need for save button appearing

//    func checkIfSavingIsNeeded() {
//
//        withAnimation {
//            checkIfItemIsDifferent()
////            checkIfSoldStatusIsChanged()
//            saveButtonIsVisible = !name.isEmpty && !price.isEmpty && priceIsValid(price: price) && itemIsChangedAndNeedsToSave
//        }
//    }
