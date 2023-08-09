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
        
//        Checking is item is new or imported, initialising new item or imported with immutable isNewItem bool
        
        if let item = item {
            self.initialItem = item
            price = String(self.initialItem.price)
            isNewItem = false

        } else {
            self.initialItem = Item(date: Date(), itemType: .undefined)
            price = ""
            isNewItem = true
        }
        
        deviceType = self.initialItem.itemType
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
        
        print(item?.fullPrice)
    }
    
    let initialItem: Item
    let isNewItem: Bool
    let tintColor: Color
    
    @Published var deviceType: ItemType
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
    
    
//    Checking if price string can be converted to int
    
    private func priceIsValid(price: String) -> Bool {
        return Int(price) != nil
    }
    
//    checking if immutable initialItem is different to current state of item based on name, price, dateOfPurchase, itemType, addons
    
    private func checkIfItemIsDifferent() {
        guard let price: Int = Int(price) else {return}
        itemIsChangedAndNeedsToSave = initialItem.name != name || initialItem.price != price || initialItem.addons != addons || initialItem.date != dateOfPurchase || initialItem.itemType != deviceType
        print("itemIsChangedAndNeedsToSave : \(itemIsChangedAndNeedsToSave)")
    }
    
//    saving item based on isNewItem property
    
    func saveItem() {
        guard priceIsValid(price: price) else {
            print("price is invalid")
            return }
        
        switch isNewItem {
        case true:
            guard !name.isEmpty, !price.isEmpty else {
                print("item can not be exported")
                return
            }
            let itemToExport = Item(name: name, price: Int(price)!, date: dateOfPurchase, addons: addons, itemType: deviceType)
            delegate?.addItemToList(item: itemToExport)
        case false:
            let itemToExport = Item(name: name, price: Int(price)!, date: dateOfPurchase, addons: addons, itemType: deviceType, id: initialItem.id)
            delegate?.editItem(item: itemToExport)
        }
        
        dismissDelegate?.dismiss()
    }
    
//    checking need for save button appearing
    
    func checkIfSavingIsNeeded() {

        
        withAnimation {
            checkIfItemIsDifferent()
            saveButtonIsVisible = !name.isEmpty && !price.isEmpty && priceIsValid(price: price) && itemIsChangedAndNeedsToSave
        }
    }
    
    func productNameChanged(newValue: String) {
        checkIfSavingIsNeeded()
        withAnimation {
            deviceType = ItemType.stringToItemType(productNameString: newValue)
        }
    }
    
    func priceChanged() {
        checkIfSavingIsNeeded()
    }
    
}
