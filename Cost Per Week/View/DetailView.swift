//
//  DetailView.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 06.07.2023.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var viewModel: DetailViewModel
    var showSaveButton = true
    
    //    MARK: -- Product info section
    
    var body: some View {
        
        
//        NavigationStack {
            Form {
                productInfoSection
                
                additionalExpensesSection
                
                isSoldSection
                
                
                if showSaveButton{
                    SaveButton
                }
                
                
            }.scrollDismissesKeyboard(.immediately)
            .onDisappear {
                viewModel.formOnDisappear()
            }
    }
}

extension DetailView {
    
//    MARK: Product Info Section
    
    var productInfoSection: some View {
        Section("Product info") {
            TextField("Product name", text: $viewModel.itemName)
                .onChange(of: viewModel.itemName, {
                    viewModel.productNameChanged()
                })
            
            HStack {
                TextField("Price", text: $viewModel.itemPurchasePrice)
                    .keyboardType(.numberPad)
                    .onChange(of: viewModel.itemPurchasePrice) {
                        viewModel.productPriceChanged()
                    }
                
                Image(systemName: viewModel.systemCurrencyIconString).foregroundColor(Color.secondary)
            }
            
            //            Purchase date datePicker
            
            DatePicker("Date of purchase", selection: $viewModel.itemDateOfPurchase, displayedComponents: [.date])
                .onChange(of: viewModel.itemDateOfPurchase, {
                    viewModel.productPurchaseDateChanged()
                })
                .datePickerStyle(.compact)
                .tint(viewModel.tintColor)
            
            
            //            Purchase type picker
            
            Picker("Type of purchase", selection: $viewModel.itemType) {
                ForEach(ItemType.allCases) { deviceType in
                    
                    Label {
                        Text(deviceType.localized())
                    } icon: {
                        Image(systemName: deviceType.SystemImageName())
                    }.tint(viewModel.tintColor)
                }.onChange(of: viewModel.itemType) {
                    viewModel.productPurchaseTypeChanged()
                }
            }.pickerStyle(.navigationLink)
        }
    }
    
    //    MARK: Additional Expenses Section
    
    @ViewBuilder
    var additionalExpensesSection: some View {
        Toggle("Additional expenses", isOn: $viewModel.additionalExpensesSectionIsVisible)
            .tint(viewModel.tintColor)
        
        if viewModel.additionalExpensesSectionIsVisible {
            
            List {
                ForEach(viewModel.itemAddons) { addon in
                    ItemAddonView(viewModel: ItemAddonViewModel(addon: addon, addonsArray: $viewModel.itemAddons, isAddNewRepairViewShown: $viewModel.addNewRepairViewIsVisible, isAddNewRepairButtonVisible: $viewModel.addNewRepairButtonIsVisible, addonsArrayIsChanged: $viewModel.addonsArrayIsChanged))
                }.onDelete { indexSet in
                    viewModel.removeAddon(at: indexSet)
                }
            }
            
            //                    showing save button in case of changing addons
            
            .onChange(of: viewModel.addonsArrayIsChanged) {
                viewModel.addonsArrayChanged()
            }
            
            
            // Showing empty ItemAddonView if new addon button is pressed, removing new addon button
            
            if viewModel.addNewRepairViewIsVisible == true
                && viewModel.addNewRepairButtonIsVisible == false
            {
                
                ItemAddonView(viewModel: ItemAddonViewModel(addon: nil, addonsArray: $viewModel.itemAddons, isAddNewRepairViewShown: $viewModel.addNewRepairViewIsVisible, isAddNewRepairButtonVisible: $viewModel.addNewRepairButtonIsVisible, addonsArrayIsChanged: $viewModel.addonsArrayIsChanged))
                
            } else {
                    
                addNewAddonButton
            }
        }
    }
    
    //    MARK: Is Sold Section
    
    var isSoldSection: some View {
        Section {
            
            Toggle("Sold", isOn: $viewModel.itemIsSold)
                .tint(viewModel.tintColor)
                .onChange(of: viewModel.itemIsSold) {
                    viewModel.soldToggleChanged()
                }
            
            if viewModel.itemIsSold {
                
                HStack {
                    
                    TextField("Price sold", text: $viewModel.priceSold)
                        .keyboardType(.numberPad)
                        .onChange(of: viewModel.priceSold) {
                            viewModel.soldItemPriceChanged()
                        }
                        
                    Image(systemName: viewModel.systemCurrencyIconString).foregroundColor(Color.secondary)
                }
                
                //            Sold date datePicker
                
                DatePicker("Date sold", selection: $viewModel.dateSold, displayedComponents: [.date])
                    .onChange(of: viewModel.dateSold, {
                        viewModel.soldDateChanged()
                    })
                    .datePickerStyle(.compact)
                    .tint(viewModel.tintColor)
                    
            }
            
        }
    }
    
    
    var SaveButton: some View {
        Button(action: {
            viewModel.save(dismiss: true)
        }) {
            Text("Save")
        }
    }
    
    var addNewAddonButton: some View {
        Button(role: .cancel) {
            viewModel.addNewRepairViewIsVisible = true
            viewModel.addNewRepairButtonIsVisible = false
            
        } label: {
            Label("Add new", systemImage: "plus")
        }
        .onAppear {

        }
    }
}




