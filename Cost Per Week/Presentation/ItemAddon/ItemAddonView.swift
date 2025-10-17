//
//  AddonItem.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 26.07.2023.
//

import SwiftUI

struct ItemAddonView: View {
    
    @StateObject var viewModel: ItemAddonViewModel
    
    var body: some View {
//        VStack {
            HStack {
                
                TextField("name", text: $viewModel.name)
                    .onChange(of: viewModel.name) {
                    viewModel.checkIfAddonShouldBeSaved()
                }
                TextField("price", text: $viewModel.price)
                    .onChange(of: viewModel.price) {
                    viewModel.checkIfAddonShouldBeSaved()
                }.keyboardType(.asciiCapableNumberPad)
            }
            
            //            Showing save button in an overlay if addon needs to be saved
            
            .overlay {
                HStack{
                    if viewModel.saveToggleIsActiveForThisAddon == true && viewModel.saved != true {
                        Spacer()
                        Button("Save") {
                            viewModel.saveToggleIsActiveForThisAddon = false
                            viewModel.saveAddon()
                            viewModel.isAddNewRepairViewVisible = true
                            viewModel.name = ""
                            viewModel.price = ""
                        }
                        .buttonStyle(.borderedProminent)
                    } else if viewModel.saveToggleIsActiveForThisAddon == false && viewModel.isAddNewRepairViewVisible == true {
                        Spacer()
                        Button("Cancel") {
                            viewModel.dismissNewAddonCreation()
                        }
                        .buttonStyle(.bordered)
                        .foregroundStyle(Color.secondary)
                    }
                }
            }
//        }
    }
}
