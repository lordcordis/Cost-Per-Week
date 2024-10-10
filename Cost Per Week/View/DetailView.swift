//
//  DetailView.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 06.07.2023.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var viewModel: DetailViewModel
    
    //    MARK: -- Product info section
    
    var body: some View {
        
        
        NavigationStack {
            Form {
                productInfoSection
                
                additionalExpensesSection
                
                isSoldSection
            }.scrollDismissesKeyboard(.immediately)
            

        }.toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if viewModel.saveButtonIsVisible {
                    SaveButton
                }
            }
        }
    }
}

extension DetailView {
    
//    MARK: Product Info Section
    
    var productInfoSection: some View {
        Section("Product info") {
            TextField("Product name", text: $viewModel.name)
                .onChange(of: viewModel.name, {
                    viewModel.productNameChanged()
                })
            
            HStack {
                TextField("Price", text: $viewModel.price)
                    .keyboardType(.numberPad)
                    .onChange(of: viewModel.price) {
                        viewModel.productPriceChanged()
                    }
                
                Image(systemName: viewModel.systemCurrencyIconString).foregroundColor(Color.secondary)
            }
            
            //            Purchase date datePicker
            
            DatePicker("Date of purchase", selection: $viewModel.dateOfPurchase, displayedComponents: [.date])
                .onChange(of: viewModel.dateOfPurchase, {
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
        Toggle("Additional expenses", isOn: $viewModel.repairsSectionIsVisible)
            .tint(viewModel.tintColor)
        
        if viewModel.repairsSectionIsVisible {
            
            List {
                ForEach(viewModel.addons) { addon in
                    ItemAddonView(viewModel: ItemAddonViewModel(addon: addon, addonsArray: $viewModel.addons, isAddNewRepairViewShown: $viewModel.addNewRepairViewIsVisible, isAddNewRepairButtonVisible: $viewModel.addNewRepairButtonIsVisible, addonsArrayIsChanged: $viewModel.addonsArrayIsChanged))
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
                
                ItemAddonView(viewModel: ItemAddonViewModel(addon: nil, addonsArray: $viewModel.addons, isAddNewRepairViewShown: $viewModel.addNewRepairViewIsVisible, isAddNewRepairButtonVisible: $viewModel.addNewRepairButtonIsVisible, addonsArrayIsChanged: $viewModel.addonsArrayIsChanged))
                
            } else {
                    
                addNewAddonButton
            }
        }
    }
    
    //    MARK: Is Sold Section
    
    var isSoldSection: some View {
        Section {
            
            Toggle("Sold", isOn: $viewModel.isSold)
                .tint(viewModel.tintColor)
                .onChange(of: viewModel.isSold) {
                    viewModel.soldToggleChanged()
                }
            
            if viewModel.isSold {
                
                HStack {
                    
                    TextField("Price sold", text: $viewModel.soldItemPrice)
                        .keyboardType(.numberPad)
                        .onChange(of: viewModel.soldItemPrice) {
                            viewModel.soldItemPriceChanged()
                        }
                        
                    Image(systemName: viewModel.systemCurrencyIconString).foregroundColor(Color.secondary)
                }
                
                //            Sold date datePicker
                
                DatePicker("Date sold", selection: $viewModel.soldDate, displayedComponents: [.date])
                    .onChange(of: viewModel.soldDate, {
                        viewModel.soldDateChanged()
                    })
                    .datePickerStyle(.compact)
                    .tint(viewModel.tintColor)
            }
            
        }
    }
    
    
    var SaveButton: some View {
        Button(action: {
            viewModel.saveItemAndDismiss()
        }) {
            Text("Save")
        }.buttonStyle(.borderedProminent)
            .transition(.move(edge: .bottom))
            .padding(.all)
            .tint(Color(uiColor: .systemPink))
            .animation(.easeIn, value: 20)
    }
    
    var addNewAddonButton: some View {
        Button(role: .cancel) {
            viewModel.addNewRepairViewIsVisible = true
            viewModel.addNewRepairButtonIsVisible = false
            
        } label: {
            Label("Add new", systemImage: "plus")
        }
        .onAppear {
//            viewModel.ch
        }
    }
}




