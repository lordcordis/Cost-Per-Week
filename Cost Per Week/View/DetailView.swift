//
//  DetailView.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 06.07.2023.
//

import SwiftUI

struct DetailView: View {
    
    init(item: Item? = nil) {
        
        guard let item = item else {return}
        self.item = item
        self.deviceType = item.itemType
        
    }
    
    var delegate: ItemDelegate?
    var item: Item?
    var dismissDelegate: DismissDelegate?
    var systemCurrencyIconString: String?
    
    
    
    private func priceIsValid(price: String) -> Bool {
        Int(price) != nil ? true : false
    }
    
    
    func saveItem() {
        
        
        
        
        if item == nil {
            guard !name.isEmpty, !price.isEmpty, priceIsValid(price: price) else {
                print("item can not be exported")
                return
            }
            let itemToExport = Item(name: name, price: Int(price)!, date: currentDate, itemType: deviceType)
            delegate?.addItemToList(item: itemToExport)
            
        } else {
            guard priceIsValid(price: price), let id = item?.id else {return}
            let itemToExport = Item(name: name, price: Int(price)!, date: currentDate, additionalPrice: nil, itemType: deviceType, id: id)
            delegate?.editItem(item: itemToExport)
        }
        
        
    }
    
    func shouldAllowSavingCheck() {
        
        withAnimation {
            toggle = !name.isEmpty && !price.isEmpty && priceIsValid(price: price)
        }
    }
    
    @State var deviceType: ItemType = .undefined
    @State var name = ""
    @State var currentDate = Date()
    @State var price: String = ""
    @State var toggle = false
    @State var repairs = false
    
    var body: some View {
        VStack {
            Form {
                Section("Product info") {
                    TextField("Product name", text: $name).onChange(of: name) {
                        
                        newValue in
                        shouldAllowSavingCheck()
                        
                        print(ItemType.stringToItemType(productNameString: newValue))
                        
                        deviceType = ItemType.stringToItemType(productNameString: newValue)
                        
                        
                    }
                    
                    HStack{
                        
                        Image(systemName: systemCurrencyIconString ?? "banknote").foregroundColor(Color.secondary)
                        
                        TextField("Enter price", text: $price)
                            .keyboardType(.numberPad)
                            .onChange(of: price) { newValue in
                                shouldAllowSavingCheck()
                            }
                    }
                    
                    DatePicker("Purchase date", selection: $currentDate, displayedComponents: [.date]).datePickerStyle(.compact).tint(Color(uiColor: UIColor.systemPink))
                    
                    Picker("Purchase type", selection: $deviceType) {
                        ForEach(ItemType.allCases) { deviceType in
                            
                            Label {
                                Text(deviceType.description())
                            } icon: {
                                Image(systemName: deviceType.SystemImageName())
                            }.tint(Color(uiColor: .systemPink))
                        }
                    }.pickerStyle(.navigationLink).tint(Color(UIColor.systemPink))
                }
                
//                Toggle("Additions", isOn: $repairs).tint(Color(uiColor: UIColor.systemPink))
                
                
            }.onAppear {
                
                if let item = item {
                    name = item.name
                    price = String(item.price)
                    currentDate = item.date
                    
                    if deviceType == .undefined {
                        deviceType = item.itemType
                    }
                }
            }
            
            if toggle {
                
                Button(action: {
                    saveItem()
                    dismissDelegate?.dismiss()
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

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
