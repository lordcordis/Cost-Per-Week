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
    
    var productInfoSection: some View {
        Section("Product info") {
            TextField("Product name", text: $viewModel.name).onChange(of: viewModel.name) {
                newValue in
                viewModel.productNameChanged(newValue: newValue)
            }
            
            HStack{
                Image(systemName: viewModel.systemCurrencyIconString).foregroundColor(Color.secondary)
                
                TextField("Enter price", text: $viewModel.price)
                    .keyboardType(.numberPad)
                    .onChange(of: viewModel.price) { newValue in
                        viewModel.priceChanged()
                    }
            }
            
//            Purchase date datePicker
            
            DatePicker("Purchase date", selection: $viewModel.dateOfPurchase, displayedComponents: [.date])
                .onChange(of: viewModel.dateOfPurchase, perform: { newValue in
                    viewModel.checkIfSavingIsNeeded()
                })
                .datePickerStyle(.compact)
                .tint(viewModel.tintColor)
            
            
//            Purchase type picker
            
            Picker("Purchase type", selection: $viewModel.deviceType) {
                ForEach(ItemType.allCases) { deviceType in
                    
                    Label {
                        Text(deviceType.description())
                    } icon: {
                        Image(systemName: deviceType.SystemImageName())
                    }.tint(viewModel.tintColor)
                }.onChange(of: viewModel.deviceType) { newValue in
                    viewModel.checkIfSavingIsNeeded()
                }
            }.pickerStyle(.navigationLink).tint(viewModel.tintColor)
        }
    }
    
    var body: some View {
        
        VStack {
            
            Form {
                
                productInfoSection
                
                Toggle("Additional expenses", isOn: $viewModel.repairsSectionIsVisible).tint(viewModel.tintColor)
                
                if viewModel.repairsSectionIsVisible {
                    
                    List {
                        ForEach(viewModel.addons) { addon in
                            ItemAddonView(viewModel: ItemAddonViewModel(addon: addon, addonsArray: $viewModel.addons, isAddNewRepairViewShown: $viewModel.addNewRepairViewIsVisible, isAddNewRepairButtonVisible: $viewModel.addNewRepairButtonIsVisible, addonsArrayIsChanged: $viewModel.addonsArrayIsChanged))
                        }.onDelete { indexSet in
                            viewModel.addons.remove(atOffsets: indexSet)
                            viewModel.checkIfSavingIsNeeded()
                        }
                    }
                    
//                    showing save button in case of changing addons
                    
                    .onChange(of: viewModel.addonsArrayIsChanged) { _ in
                        viewModel.checkIfSavingIsNeeded()
                    }
                    
                    
                    
                    // Showing empty ItemAddonView if new addon button is pressed, removing new addon button
                    
                    if viewModel.addNewRepairViewIsVisible == true
                        && viewModel.addNewRepairButtonIsVisible == false
                    {
                        
                        ItemAddonView(viewModel: ItemAddonViewModel(addon: nil, addonsArray: $viewModel.addons, isAddNewRepairViewShown: $viewModel.addNewRepairViewIsVisible, isAddNewRepairButtonVisible: $viewModel.addNewRepairButtonIsVisible, addonsArrayIsChanged: $viewModel.addonsArrayIsChanged))
                        
                    } else {
                        
//                        Add new add-on button
                        
                        Button(role: .cancel) {
                            viewModel.addNewRepairViewIsVisible = true
                            viewModel.addNewRepairButtonIsVisible = false
                            
                        } label: {
                            Label("Add new", systemImage: "plus")
                        }
                        .onAppear {
                            viewModel.checkIfSavingIsNeeded()
                        }
                    }
                }
            }

            
            if viewModel.saveButtonIsVisible {
                
                Button(action: {
                    viewModel.saveItem()
                }) {
                    Text("Save")
                }.buttonStyle(.borderedProminent)
                    .transition(.move(edge: .bottom))
                    .padding(.all)
                    .tint(Color(uiColor: .systemPink))
                    .animation(.easeIn, value: 20)
            }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}






