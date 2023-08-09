//
//  SettingsView.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 12.07.2023.
//

import SwiftUI

struct SettingsView: View {
    
    init(weekOrDay: Bool) {
        
        switch weekOrDay {
        case true:
            weekOrDayBool = .week
        case false:
            weekOrDayBool = .day
        }
    }
    
    
    var delegate: ChangeWeekOrDayInItemsTableViewDelegate?
    
    let currencyAllCases = Currency.allCases
    @State var weekOrDayBool: Item.pricePerWeekOrDay = .week
    @State private var selectedCurrency = Currency.dollar
    
    var body: some View {
        Form {
            
            Section() {
                Picker("Choose time period:", selection: $weekOrDayBool) {
                    ForEach(Item.pricePerWeekOrDay.allCases) {
                        result in
                        Text(result.rawValue.capitalized)
                    }
                }.pickerStyle(.inline)
                //                    .padding(.all)
                    .onChange(of: weekOrDayBool) { newValue in
                        switch newValue{
                        case .week:
                            UserDefaults.standard.set(true, forKey: Persistency.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)
                            delegate?.refreshTitle()
                        case .day:
                            UserDefaults.standard.set(false, forKey: Persistency.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)
                            delegate?.refreshTitle()
                        }
                    }
            }
            
            
            Section() {
                
                Picker("Select a currency:", selection: $selectedCurrency) {
                    ForEach(Currency.allCases, id: \.self) { currency in
                        Label {
                            Text(currency.returnCurrency().currencyFullTitle)
                        } icon: {
                            Image(systemName: currency.returnCurrency().imageSystamName)
                        }.tag(currency)
                    }
                }
                .pickerStyle(.inline)
                .onChange(of: selectedCurrency) { newValue in
                    
                    CurrencyObject.saveCurrencyAsDefault(currency: newValue.returnCurrency())
                    delegate?.refreshCurrency(currencyString: newValue.returnCurrency().currencyString)
                    delegate?.refreshTitle()
                }
            }
            
        }.onAppear {
            
//            let currencyString = Currency.currency
            let currencyString = CurrencyObject.currencyString()
            if let selectedCurrencyFromUserDefaults = Currency.allCases.first(where: {
                currencyY
                in
                currencyY.returnCurrency().currencyString == currencyString
            }) {
                selectedCurrency = selectedCurrencyFromUserDefaults
            }
            
            let weekIfTrue = UserDefaults.standard.bool(forKey: Persistency.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)
            
            switch weekIfTrue {
            case true:
                weekOrDayBool = .week
            case false:
                weekOrDayBool = .day
            }
        }
        .onDisappear {
//            delegate?.refreshTitle()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(weekOrDay: true)
    }
}
