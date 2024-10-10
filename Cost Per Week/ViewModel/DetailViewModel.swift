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
        
        //        Init is checking if item is new or imported
        
        if let item = item {
            
            //        item is imported
            
            print("imported item: \(item)")
            
            self.initialItem = item
            price = String(self.initialItem.price)
            isNewItem = false
            self.isSold = item.isSold
            
            //            Checking if item has soldInfo
            
            if let soldInfo = item.soldInfo {
                self.soldDate = soldInfo.dateSold
                self.soldItemPrice = String(soldInfo.priceSold)
            }
            
        } else {
            
            //            Item is new
            
            isNewItem = true
            price = ""
            self.initialItem = Item(date: Date(), itemType: .undefined, isSold: false)
            self.isSold = false
        }
        
        itemType = self.initialItem.itemType
        name = self.initialItem.name
        dateOfPurchase = self.initialItem.date
        
        addons = self.initialItem.addons ?? []
        systemCurrencyIconString = systemCurrencyString
        tintColor = Color(uiColor: UIColor.systemPink)
        
        if !addons.isEmpty {
            repairsSectionIsVisible = true
        }
        
        self.dismissDelegate = dismissDelegate
        self.delegate = delegate
    }
    
    let initialItem: Item
    let isNewItem: Bool
    let tintColor: Color
    
    @Published var itemType: ItemType
    @Published var name: String
    @Published var dateOfPurchase: Date
    @Published var price: String
    @Published var addons: [ItemAddon]
    
    @Published var addNewRepairViewIsVisible = false
    @Published var addNewRepairButtonIsVisible = true
    @Published var saveButtonIsVisible: Bool = false
    @Published var repairsSectionIsVisible: Bool = false
    @Published var addonsArrayIsChanged: Bool = false
    
    @Published var itemIsChangedAndNeedsToSave: Bool = false
    
    var delegate: ItemTableViewDelegate?
    var dismissDelegate: DismissDelegate?
    let systemCurrencyIconString: String
    
    @Published var isSold: Bool = false
    @Published var soldItemPrice: String = ""
    @Published var soldDate: Date = Date()
    
    //    @Published var soldDataChanged = false
    var soldInfo: SoldInfo?
    
    //    Checking if price string can be converted to int
    
    private func priceIsValid(price: String) -> Bool {
        return Int(price) != nil
    }
    
    //    checking if immutable initialItem is different to current state of item based on name, price, dateOfPurchase, itemType, addons
    
    private func checkIfItemChangedAndSave() {
        
        guard let priceInt = Int(price) else {return}
        
        let itemToExport = Item(name: name, price: priceInt, date: dateOfPurchase, addons: addons, itemType: itemType, id: initialItem.id, isSold: isSold, soldInfo: soldInfo)
        
        if itemToExport != initialItem {
            print("item did change, saving")
            saveItem()
        }
        
        
    }
    
    
//    private func checkIfItemIsDifferent() {
//        guard let price: Int = Int(price) else {return}
//        
//        if let soldInfo = initialItem.soldInfo, let soldItemPriceInt = Int(soldItemPrice) {
//            itemIsChangedAndNeedsToSave = initialItem.name != name
//            || initialItem.price != price
//            || initialItem.addons != addons
//            || initialItem.date != dateOfPurchase
//            || initialItem.itemType != itemType
//            || soldInfo.dateSold != soldDate
//            || soldInfo.priceSold != soldItemPriceInt
//            || initialItem.isSold != isSold
//        } else {
//            itemIsChangedAndNeedsToSave = initialItem.name != name
//            || initialItem.price != price
//            || initialItem.addons != addons
//            || initialItem.date != dateOfPurchase
//            || initialItem.itemType != itemType
//            || initialItem.isSold != isSold
//        }
//        
//        print("itemIsChangedAndNeedsToSave : \(itemIsChangedAndNeedsToSave)")
//    }
    
    //    saving item based on isNewItem property
    
    func saveItem() {
        guard priceIsValid(price: price) else {
            print("price is invalid")
            return }
        
        switch isNewItem {
            
        case true:
            
            guard !name.isEmpty, !price.isEmpty else {
                print("new item can not be exported, !name.isEmpty, !price.isEmpty")
                return
            }
            
            var itemToExport: Item
            
            //            if let soldInfo = self.soldInfo {
            //                itemToExport = Item(name: name, price: Int(price)!, date: dateOfPurchase, addons: addons, itemType: itemType, isSold: isSold, soldInfo: soldInfo)
            //
            //            } else {
            generateSoldInfo()
            itemToExport = Item(name: name, price: Int(price)!, date: dateOfPurchase, addons: addons, itemType: itemType,isSold: isSold)
            //
            //            }
            
            delegate?.addItemToList(item: itemToExport)
            
            
        case false:
            
            var itemToExport: Item
            
            //            if let soldInfo = self.soldInfo {
            //                itemToExport = Item(name: name, price: Int(price)!, date: dateOfPurchase, addons: addons, itemType: itemType, id: initialItem.id, isSold: isSold, soldInfo: soldInfo)
            //            } else {
            generateSoldInfo()
            itemToExport = Item(name: name, price: Int(price)!, date: dateOfPurchase, addons: addons, itemType: itemType, id: initialItem.id, isSold: isSold, soldInfo: soldInfo)
            //            }
            
            delegate?.editItem(item: itemToExport)
        }
    }
    
    func saveItemAndDismiss() {
        guard priceIsValid(price: price) else {
            print("price is invalid")
            return }
        
        switch isNewItem {
        case true:
            guard !name.isEmpty, !price.isEmpty else {
                print("item can not be exported")
                return
            }
            
            var itemToExport: Item
            
            
            itemToExport = Item(name: name, price: Int(price)!, date: dateOfPurchase, addons: addons, itemType: itemType, isSold: isSold, soldInfo: soldInfo)
            
            
            
            delegate?.addItemToList(item: itemToExport)
            
            
        case false:
            
            var itemToExport: Item
            
            if let soldInfo = self.soldInfo {
                itemToExport = Item(name: name, price: Int(price)!, date: dateOfPurchase, addons: addons, itemType: itemType, id: initialItem.id, isSold: self.isSold, soldInfo: soldInfo)
            } else {
                itemToExport = Item(name: name, price: Int(price)!, date: dateOfPurchase, addons: addons, itemType: itemType, id: initialItem.id, isSold: self.isSold)
            }
            
            delegate?.editItem(item: itemToExport)
        }
        
        
        
        dismissDelegate?.dismiss()
    }
    
    //    checking need for save button appearing
    
//    func checkIfSavingIsNeeded() {
//        
//        withAnimation {
//            checkIfItemIsDifferent()
////            checkIfSoldStatusIsChanged()
//            saveButtonIsVisible = !name.isEmpty && !price.isEmpty && priceIsValid(price: price) && itemIsChangedAndNeedsToSave
//        }
//    }
    
    //    MARK: -- Product Info Methods
    
    func productNameChanged() {
        //        checkIfSavingIsNeeded()
        checkIfItemChangedAndSave()
        withAnimation {
            itemType = ItemType.stringToItemType(productNameString: name)
        }
    }
    
    func productPriceChanged() {
        //        checkIfSavingIsNeeded()
        checkIfItemChangedAndSave()
    }
    
    func productPurchaseDateChanged() {
        //        checkIfSavingIsNeeded()
        checkIfItemChangedAndSave()
    }
    
    func productPurchaseTypeChanged() {
//        checkIfSavingIsNeeded()
        checkIfItemChangedAndSave()
    }
    
    //      MARK: Additional Expenses Methods
    
    func removeAddon(at indexSet: IndexSet) {
        addons.remove(atOffsets: indexSet)
//        checkIfSavingIsNeeded()
        checkIfItemChangedAndSave()
    }
    
    func addonsArrayChanged() {
//        checkIfSavingIsNeeded()
        checkIfItemChangedAndSave()
    }
    
    
    
    
    //    MARK: Item Sold Methods
    
    func checkIfSoldDataIsValid() -> Bool {
        return !soldItemPrice.isEmpty
    }
    
    func soldItemPriceChanged() {
        generateSoldInfo()
        checkIfItemChangedAndSave()
    }
    
    func soldDateChanged() {
        generateSoldInfo()
        checkIfItemChangedAndSave()
    }
    
    private func generateSoldInfo() {
        guard let priceSold: Int = Int(soldItemPrice) else {return}
        print("generating sold info")
        let newSoldInfo = SoldInfo(dateSold: soldDate, priceSold: priceSold)
        self.soldInfo = newSoldInfo
    }
    
    func soldToggleChanged() {
        saveItem()
    }
}
