//
//  ItemAddonViewModel.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 10.08.2023.
//

import Foundation
import SwiftUI

final class ItemAddonViewModel: ObservableObject {
    
    init(addon: ItemAddon?,
         addonsArray: Binding<[ItemAddon]>,
         isAddNewRepairViewShown: Binding<Bool>,
         isAddNewRepairButtonVisible: Binding<Bool>,
         addonsArrayIsChanged: Binding<Bool>) {
        
        if let addon = addon {
//            Addon is imported
            self.isAddonNew = false
            self.itemAddonInitialValue = addon
            name = addon.description
            price = String(addon.price)
        } else {
//            Addon is new
            self.isAddonNew = true
            self.itemAddonInitialValue = ItemAddon(description: "",
                                                   price: 0,
                                                   id: UUID().uuidString)
        }
        
        _isAddNewRepairViewVisible = isAddNewRepairViewShown
        _addonsArray = addonsArray
        _isAddNewRepairButtonVisible = isAddNewRepairButtonVisible
        _addonsArrayIsChanged = addonsArrayIsChanged
    }
    @Binding var addonsArrayIsChanged: Bool
    @Binding var isAddNewRepairViewVisible: Bool
    @Binding var isAddNewRepairButtonVisible: Bool
    @Binding var addonsArray: [ItemAddon]
    
    @Published var name = ""
    @Published var price = ""
    @Published var saveToggleIsActiveForThisAddon = false
    @Published var saved = true
    
    let itemAddonInitialValue: ItemAddon
    var isAddonNew: Bool
    
    func checkIfAddonShouldBeSaved() {
        withAnimation {
            checkIfDataChanged()
            isSaveToggleActive()
        }
    }
    
    private func isSaveToggleActive() {
        saveToggleIsActiveForThisAddon = !name.isEmpty && !price.isEmpty && Int(price) != nil
    }
    
    private func checkIfDataChanged () {
        saved = itemAddonInitialValue.description == name && String(itemAddonInitialValue.price) == price
    }
    
    func saveAddon() {
        guard let priceAsString = Int(price) else {return}
        let addonToExport = ItemAddon(description: name, price: priceAsString, id: itemAddonInitialValue.id)
        
        switch isAddonNew {
            
        case true:
            withAnimation {
                addonsArray.append(addonToExport)
            }
            isAddonNew = false
            
        case false:
            
            if let index = addonsArray.firstIndex(where: { addon in
                addon.id == addonToExport.id
            }) {
                addonsArray[index] = addonToExport
            }
        }
        
        withAnimation {
            isAddNewRepairViewVisible = false
            isAddNewRepairButtonVisible = true
            addonsArrayIsChanged = true
        }
    }
}

extension ItemAddonViewModel {
    func dismissNewAddonCreation() {
        withAnimation {
            isAddNewRepairViewVisible = false
            isAddNewRepairButtonVisible = true
        }
    }
}
