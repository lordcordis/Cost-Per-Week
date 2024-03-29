//
//  SettingsView.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 12.07.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel: SettingsViewModel
    
    var body: some View {
        Form {
            
//            Picker("Choose view type:", selection: $viewModel.simpleOrDetailedViewType) {
//                ForEach(SettingsViewModel.ViewType.allCases) {
//                    result in
//                    Text(result.rawValue.capitalized)
//                }
//            }.pickerStyle(.inline)
            
                Picker("Choose time period:", selection: $viewModel.weekOrDayBool) {
                    ForEach(Item.pricePerWeekOrDay.allCases) {
                        result in
                        Text(result.rawValue.capitalized)
                    }
                }.pickerStyle(.inline)
                    .onChange(of: viewModel.weekOrDayBool) { newValue in
                        viewModel.saveDayOrWeek(newValue)
                    }

            Picker("Select currency:", selection: $viewModel.selectedCurrency) {
                ForEach(Currency.allCases, id: \.self) { currency in
                    Label {
                        Text(currency.returnCurrency().currencyFullTitle)
                    } icon: {
                        Image(systemName: currency.returnCurrency().imageSystemName)
                    }.tag(currency)
                }
            }
            .pickerStyle(.inline)
            .onChange(of: viewModel.selectedCurrency) { newValue in
                viewModel.saveCurrency(newValue)
            }
            
        }
        
        
        
        
        
        //        .onAppear {
        //
        //            //            let currencyString = Currency.currency
        //            let currencyString = CurrencyObject.currencyString()
        //            if let selectedCurrencyFromUserDefaults = Currency.allCases.first(where: {
        //                currencyY
        //                in
        //                currencyY.returnCurrency().currencyString == currencyString
        //            }) {
        //                viewModel.selectedCurrency = selectedCurrencyFromUserDefaults
        //            }
        //
        //            let weekIfTrue = UserDefaults.standard.bool(forKey: Persistency.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)
        //
        //            switch weekIfTrue {
        //            case true:
        //                viewModel.weekOrDayBool = .week
        //            case false:
        //                viewModel.weekOrDayBool = .day
        //            }
        //        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView()
//    }
//}
