//
//  SheetView.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 06.07.2023.
//

import SwiftUI

extension ItemsTableViewController: ChangeWeekOrDayInItemsTableViewDelegate {
    
    
    func refreshCurrency(currencyString: String) {
        let currency = Currency.stringIntoCurrencyObject(currencyString: currencyString)
        viewModel.setCurrency(currency)
    }
    
    func refreshTitle() {
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
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    
    func showSheetView(message: String) {
        
        let sheetController = UIHostingController(rootView: SheetView(message: message))
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
    
    static let sampleMessage = "Per week: 10000 RUB"
    
    let message: String
    var body: some View {
        
        ZStack {
            Color.init(uiColor: UIColor.clear)
            VStack {
                Text("Total Cost").font(.title).padding(.all).fontWeight(.semibold)
                Text(message).font(.title2).padding(.all).multilineTextAlignment(.center).fontWeight(.semibold)
            }
        }.background(.ultraThinMaterial)
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(message: SheetView.sampleMessage)
    }
}
