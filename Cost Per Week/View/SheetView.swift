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
        items = persistency.retreveData() ?? []
        weekOrDayBool = UserDefaults.standard.bool(forKey: Persistency.KeysForUserDefaults.pricePerWeekIfTrue.rawValue)
    }
    
    let weekOrDayBool: Bool
    let persistency = Persistency()
    
    static let sampleMessage = "Per week: 10000 RUB"
    
    var items: [Item]
    
    let message: String
    let message2: String
    var body: some View {
        
        ZStack {
            Color.init(uiColor: UIColor.clear)
            VStack {

                
                
                
                
                TabView {
                    
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
                    
                    VStack {
                        
                        
                        Text(message2)
                            .font(.title2)
                            .padding(.all)
                            .multilineTextAlignment(.center)
                            .fontWeight(.semibold)
                            .padding()
                        
                        Chart {
                            
                            
                                ForEach(items) {item in
                                    BarMark(x: .value("value 1", item.date), y: .value("value 2", item.fullPrice))
                                        
                                }
                            
                                
                            
                            
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 40)
                        .padding()

                    }
                    
                    
                    
                }.tabViewStyle(.page)
                
                
                
            }
        }.background(.ultraThinMaterial)
    }
}
