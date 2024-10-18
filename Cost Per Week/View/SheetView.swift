//
//  SheetView.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 06.07.2023.
//

import SwiftUI
import Charts

extension ItemsTableViewController: ChangeWeekOrDayInItemsTableViewDelegate {
    
    
    func refreshCurrency(currencyString: String) {
        let currency = Currency.stringIntoCurrencyObject(currencyString: currencyString)
        viewModel.setCurrency(currency)
    }
    
    func refreshTitleAndReloadTableView() {
        title = viewModel.viewTitle()
        tableView.reloadData()
    }
    
    func showSettingsView() {
        
        
        let viewModel = SettingsViewModel(weekOrDay: viewModel.weekOrDayBool, delegate: self)
        let viewToPresent = SettingsView(viewModel: viewModel)
        //        viewToPresent.delegate = self
        
        let sheetController = UIHostingController(rootView: viewToPresent)
        
        let viewControllerToPresent = sheetController
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.largestUndimmedDetentIdentifier = .none
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            //            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        //        self.addChild(viewControllerToPresent)
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    
    func showSheetView(message: String, message2: String) {
        
        let sheetController = UIHostingController(rootView: SheetView(message: message, message2: message2))
        sheetController.view.backgroundColor = UIColor.clear
        
        let viewControllerToPresent = sheetController
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.largestUndimmedDetentIdentifier = .none
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
}

struct SheetView: View {
    
    init(message: String, message2: String) {
        self.message = message
        self.message2 = message2
        
        if let itemsRetreieved = persistency.retreveData() {
//            let itemsNotSold = itemsRetreieved.filter { item in
//                item.isSold == false
//            }
            
            items = itemsRetreieved
            
            
        } else {
            items = []
        }
        
        weekOrDayBool = UserDefaults.standard.bool(forKey: Persistency.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)
        
        var output = 0
        let itemsRetreieved = persistency.retreveData()
        
        var outputTotal = 0
        
        for item in items {
            outputTotal += item.price
        }
        
        var outputSold = 0
        
        for item in items {
            if item.isSold {
                outputSold += item.priceSold
            }
        }
        
        var outputBalance = outputTotal - outputSold
        

       
        self.messageTotal = String(outputTotal)
        self.messageSold = String(outputSold)
        self.messageBalance = String(outputBalance)
    }
    
    let priceTotalLabel: LocalizedStringKey = "Price of all items"
    let soldLabel: LocalizedStringKey = "Sold"
    let balanceLabel: LocalizedStringKey = "Balance"

    let currencyString = CurrencyObject.currencyString()
    
    @State var messageTotal: String
    @State var messageSold: String
    @State var messageBalance: String
    
    let weekOrDayBool: Bool
    let persistency = Persistency()
    
//    static let sampleMessage = "Per week: 10000 RUB"
    
    var items: [Item]
    
    let message: String
    var message2: String
    var body: some View {
        
        ZStack {
            Color.init(uiColor: UIColor.clear)
            VStack {
                
                TabView {
                    
//                    firstTab
                    secondTab

                }.tabViewStyle(.page)
            }
        }.background(.ultraThinMaterial)
    }
    

    

    
}

extension SheetView {
    var secondTab: some View {
        VStack {
            VStack {
                HStack {
                    Text(priceTotalLabel)
                    Text(messageTotal)
                    Text(currencyString)
                }
                
                HStack {
                    Text(soldLabel)
                    Text(messageSold)
                    Text(currencyString)
                }
                
                HStack {
                    Text(balanceLabel)
                    Text(messageBalance)
                    Text(currencyString)
                }
            }.font(.headline)
                .padding()
            
//            Text(message2)
//                .font(.title2)
//                .padding(.all)
//                .multilineTextAlignment(.center)
//                .fontWeight(.semibold)
//                .padding()
            
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
    }
}

extension SheetView {
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
