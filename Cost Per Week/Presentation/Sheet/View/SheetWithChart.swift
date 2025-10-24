//
//  SheetWithChartView.swift
//  CostPerWeek
//
//  Created by Роман Коренев on 18.10.25.
//

import SwiftUI
import Charts

struct SheetWithChartView: View {
    
    init(message: String, message2: String) {
        self.message = message
        self.message2 = message2
        
        if let itemsRetreieved = persistency.retreveData() {
            items = itemsRetreieved
        } else {
            items = []
        }
        
        weekOrDayBool = UserDefaults.standard.bool(forKey: PersistenceManager.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)
        
        var outputTotal = 0
        
        for item in items {
            outputTotal += item.price
        }
        
        var outputSold = 0
        
        for item in items where item.isSold {
            outputSold += item.priceSold
        }
        
        let outputBalance = outputTotal - outputSold
        
        self.messageTotal = String(outputTotal)
        self.messageSold = String(outputSold)
        self.messageBalance = String(outputBalance)
    }
    
    let priceTotalLabel: LocalizedStringKey = "Price of all items"
    let soldLabel: LocalizedStringKey = "Sold"
    let balanceLabel: LocalizedStringKey = "Balance"

    let currencyString = Currency.currencyString()
    
    @State var messageTotal: String
    @State var messageSold: String
    @State var messageBalance: String
    
    let weekOrDayBool: Bool
    let persistency = PersistenceManager()
    
    var items: [Item]
    
    let message: String
    var message2: String
    var body: some View {
        
        ZStack {
            Color.clear
            VStack {
                
                TabView {
                    
//                    firstTab
//                    secondTab
                    secondTabAlt

                }.tabViewStyle(.page)
            }
        }.background(.ultraThinMaterial)
    }
}

extension SheetWithChartView {
    
    var secondTabAlt: some View {
        VStack(alignment: .center) {
            // Full Price
            HStack(alignment: .firstTextBaseline) {
                Text(priceTotalLabel)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(messageTotal)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                Text(currencyString ?? "")
                    .font(.headline)
                    .foregroundColor(.primary)
            }.padding(.top)
            
            // Sold Amount
            HStack(alignment: .firstTextBaseline) {
                Text(soldLabel)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(messageSold)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                Text(currencyString ?? "")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            
            // Balance
            HStack(alignment: .firstTextBaseline) {
                Text(balanceLabel)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(messageBalance)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                Text(currencyString ?? "")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            
            chartView
        }
    }
    
    var secondTab: some View {
        VStack {
            VStack {
                HStack {
                    Text(priceTotalLabel)
                    Text(messageTotal)
                    Text(currencyString ?? "")
                }
                
                HStack {
                    Text(soldLabel)
                    Text(messageSold)
                    Text(currencyString ?? "")
                }
                
                HStack {
                    Text(balanceLabel)
                    Text(messageBalance)
                    Text(currencyString ?? "")
                }
            }.font(.headline)
                .padding()
            
            chartView
        }
    }
}

extension SheetWithChartView {
    
    var chartView: some View {
        Chart {
            ForEach(items) { item in
                BarMark(x: .value("value 1", item.date), y: .value("value 2", item.fullPrice))
                    .foregroundStyle(item.isSold ? .secondary : .primary)
                
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 40)
        .padding()
    }
    
    var firstTab: some View {
        VStack {
            
            Text(message)
                .font(.title2)
                .padding(.all)
                .multilineTextAlignment(.center)
                .fontWeight(.semibold)
                .padding()
            
            Chart {
                
                if weekOrDayBool {
                    ForEach(items) {item in
                        BarMark(x: .value("value 1", item.date), y: .value("value 2", item.pricePerWeek))
                    }
                    
                } else {
                    ForEach(items) {item in
                        BarMark(x: .value("value 1", item.date), y: .value("value 2", item.pricePerDay))
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
            .padding()
        }
    }
}
