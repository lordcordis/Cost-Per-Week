//
//  SettingsView.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 12.07.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @StateObject var viewModel: SettingsViewModel
    @Binding var sheetIsPresented: Bool
    
    let deleteAllDataButtonVisible = false
    let alertDeleteText = "Are you sure you want to delete all data?"
    @State var alertDeleteIsPresented = false
    
    var body: some View {
        NavigationStack {
            Form {
                
                Picker("Choose time period:", selection: $viewModel.weekOrDayBool) {
                    ForEach(Item.PriceTimePeriod.allCases) { result in
                        Text(result.localizedLabel)
                    }
                }.pickerStyle(.inline)
                    .onChange(of: viewModel.weekOrDayBool) {
                        viewModel.saveDayOrWeek()
                    }
                
                Picker("Select currency:", selection: $viewModel.selectedCurrency) {
                    ForEach(Currency.allCases, id: \.self) { currency in
                        Label {
                            Text(currency.title)
                        } icon: {
                            Image(systemName: currency.iconName)
                        }.tag(currency)
                    }
                }
                .pickerStyle(.inline)
                .onChange(of: viewModel.selectedCurrency) {
                    viewModel.saveCurrency()
                }
                
                if deleteAllDataButtonVisible {
                    Button("Delete all data...") {
                        alertDeleteIsPresented.toggle()
                    }.alert(alertDeleteText, isPresented: $alertDeleteIsPresented) {
                        Button("YES") {
                            viewModel.deleteAllData()
                        }
                        Button("NO") {
                            
                        }
                    }
                }
                
            }.navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            sheetIsPresented = false
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                })
        }
    }
}
