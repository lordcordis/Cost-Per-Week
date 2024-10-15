//
//  ItemAddonViewAlt.swift
//  CostPerWeek
//
//  Created by lordcordis on 15.10.2024.
//

import SwiftUI
import Combine

struct ItemAddonViewAlt: View {
    
    enum buttonVisible {
        case nothing
        case save
        case cancel
    }
    
    let initialAddon: ItemAddon
    @Binding var itemAddons: [ItemAddon]
    @Binding var newAddonToggle: DetailViewModel.newAddonToggle
    
    @State var buttonVisibleToggle: buttonVisible = .nothing
    
    init(addon: ItemAddon?, itemAddons: Binding<[ItemAddon]>, newAddonToggle: Binding<DetailViewModel.newAddonToggle>) {
        
        
        if let addon = addon {
            self.initialAddon = addon
            self.name = addon.description
            self.price = String(addon.price)
            
        } else {
            self.name = ""
            self.price = ""
            self.initialAddon = ItemAddon(description: "", price: 0, id: UUID().uuidString)
        }

        self._itemAddons = itemAddons
        self._newAddonToggle = newAddonToggle
    }
    
    @State var name: String
    @State var price: String
    
    func save() {
        guard let priceInt = Int(price) else {return}
        let exportedAddon = ItemAddon(description: name, price: priceInt, id: initialAddon.id)
        
        name = ""
        price = ""
        
        var isExportedSuccessfully = false
        
        for (index, itemAddon) in itemAddons.enumerated() {
            if itemAddon.id == exportedAddon.id {
                itemAddons[index] = exportedAddon
                isExportedSuccessfully = true
                showAddNewButton()
            }
        }
        
        if isExportedSuccessfully == false {
            itemAddons.append(exportedAddon)
            showAddNewButton()
        }
    }
    
    func showAddNewButton() {
        newAddonToggle = .addNewButton
    }
    
    func textFieldChanged() {
        checkIfSaveButtonShouldBeShown()
    }
    
    func priceFieldChanged() {
        checkIfSaveButtonShouldBeShown()
    }
    
    func checkIfSaveButtonShouldBeShown() {
        
        switch (name.isEmpty, price.isEmpty) {
        case (true, true):
            buttonVisibleToggle = .nothing
            
        case (false, false):
            buttonVisibleToggle = .save
            
        default:
            buttonVisibleToggle = .cancel
        }
    }
    
    var body: some View {
        
        HStack {
            
            TextField("name", text: $name)
                .onChange(of: name) {
                    textFieldChanged()
                }
            
            TextField("price", text: $price)
                .onChange(of: price, {
                    priceFieldChanged()
                })
                .keyboardType(.asciiCapableNumberPad)
            
        }.overlay {
            
            switch buttonVisibleToggle {
                
            case .nothing:
                EmptyView()
                
            case .save:
                HStack {
                    Spacer()
                    Button("Save") {
                        save()
                    }
                    .buttonStyle(.borderedProminent)
                    
                }
                
            case .cancel:
                HStack {
                    Spacer()
                    Button("Cancel") {
                        showAddNewButton()
                    }
                    .buttonStyle(.bordered)
                    
                }
            }
        }
    }
}

