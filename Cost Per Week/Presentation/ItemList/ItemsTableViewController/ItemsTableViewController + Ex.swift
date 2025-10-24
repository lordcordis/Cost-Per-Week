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
        let currency = Currency.selectedCurrency() ?? .dollar
        viewModel.setCurrency(currency)
    }
    
    func refreshTitleAndReloadTableView() {
        title = viewModel.viewTitle()
        tableView.reloadData()
    }
    
//    func showSettingsAsHosted() {
//        
//        let viewModel = SettingsViewModel(weekOrDay: viewModel.weekOrDayBool, delegate: self)
////        let viewToPresent = SettingsView(viewModel: viewModel)
//        
//        let sheetController = UIHostingController(rootView: viewToPresent)
//        
//        let viewControllerToPresent = sheetController
//        if let sheet = viewControllerToPresent.sheetPresentationController {
//            sheet.detents = [.large()]
//            sheet.largestUndimmedDetentIdentifier = .none
//            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
//            sheet.prefersEdgeAttachedInCompactHeight = true
//            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
//            sheet.preferredCornerRadius = 20
//        }
//        
//        present(viewControllerToPresent, animated: true, completion: nil)
//    }
    
    func showSheetAsHosted(message: String, message2: String) {
        
        let sheetController = UIHostingController(rootView: SheetWithChartView(message: message, message2: message2))
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
        
        present(viewControllerToPresent, animated: true)
    }
}
