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
        VStack {
            HStack {
                
//                Setting up textfields
                
                TextField("name", text: $viewModel.name).onChange(of: viewModel.name) { _ in
                    viewModel.checkIfAddonShouldBeSaved()
                }
                TextField("price", text: $viewModel.price).onChange(of: viewModel.price) { _ in
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
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
        }
    }
}


//struct AddonItem_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemAddonView(addon: ItemAddon.sampleItemAddon, isToggleOn: true, addons: [ItemAddon.sampleItemAddon])
//    }
//}



