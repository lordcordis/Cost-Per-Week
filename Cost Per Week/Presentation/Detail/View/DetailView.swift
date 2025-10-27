//
//  DetailView.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 06.07.2023.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var viewModel: DetailViewModel
    var showSaveButton = false
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: -- Product info section
    
    var body: some View {
        
        Form {
            productInfoSection
            
            additionalExpensesSectionAlt
            
            isSoldSection
            
            if showSaveButton{
                saveButton
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                saveButton
            }
        })
        .scrollDismissesKeyboard(.immediately)
    }
}

extension DetailView {
    
    // MARK: Product Info Section
    
    var productInfoSection: some View {
        Section("Product info") {
            TextField("Product name", text: $viewModel.itemName)
                .onChange(of: viewModel.itemName, {
                    viewModel.productNameChanged()
                })
            
            HStack {
                TextField("Price", text: $viewModel.itemPurchasePrice)
                    .keyboardType(.numberPad)
                    .onChange(of: viewModel.itemPurchasePrice) { _, newValue in
                        var filtered = newValue
                        filtered = filtered.filter { $0.isNumber }
                        viewModel.itemPurchasePrice = filtered
                    }
                
                Image(systemName: viewModel.systemCurrencyIconString).foregroundColor(Color.secondary)
            }
            
            // Purchase date datePicker
            
            DatePicker("Date of purchase", selection: $viewModel.itemDateOfPurchase, in: viewModel.purchasedDatesRange, displayedComponents: [.date])
                .onChange(of: viewModel.itemDateOfPurchase, {
                    viewModel.productPurchaseDateChanged()
                })
                .datePickerStyle(.compact)
                .tint(viewModel.tintColor)
            
            //  Purchase type picker
            
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
    
    // MARK: Additional Expenses Section
    
    @ViewBuilder
    var additionalExpensesSectionAlt: some View {
        Toggle("Additional expenses", isOn: $viewModel.additionalExpensesEnabled)
            .tint(viewModel.tintColor)
        
        if viewModel.additionalExpensesEnabled {
            List {
                ForEach(viewModel.itemAddons) { addon in
                    ItemAddonView(addon: addon, itemAddons: $viewModel.itemAddons, newAddonToggle: $viewModel.newAddonToggle)
                }.onDelete { indexSet in
                    viewModel.removeAddon(at: indexSet)
                }
            }
            
            switch viewModel.newAddonToggle {
            case .newAddon:
                ItemAddonView(addon: nil, itemAddons: $viewModel.itemAddons, newAddonToggle: $viewModel.newAddonToggle)
            case .addNewButton:
                addNewAddonButtonAlt
            }
        }
    }
    
    // MARK: Is Sold Section
    
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
                
                // Sold date datePicker
                
                DatePicker("Date sold", selection: $viewModel.dateSold, in: viewModel.soldDatesRange, displayedComponents: [.date])
                    .onChange(of: viewModel.dateSold, {
                        viewModel.soldDateChanged()
                    })
                    .datePickerStyle(.compact)
                    .tint(viewModel.tintColor)
            }
        }
    }
    
    var saveButton: some View {
        Button(action: {
            viewModel.save(dismiss: true)
            dismiss()
        }) {
            Text("Save")
        }
    }
    
    var addNewAddonButton: some View {
        Button(role: .cancel) {
            withAnimation {
                viewModel.addNewRepairViewIsVisible = true
                viewModel.addNewRepairButtonIsVisible = false
            }
            
        } label: {
            Label("Add new", systemImage: "plus")
        }
        .onAppear {
            
        }
    }
    
    var addNewAddonButtonAlt: some View {
        Button(role: .cancel) {
            withAnimation {
                viewModel.newAddonToggle = .newAddon
            }
        } label: {
            Label("Add new", systemImage: "plus")
        }
    }
}
