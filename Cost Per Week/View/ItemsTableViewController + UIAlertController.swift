//
//  ItemsTableViewController + Extension.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 11.05.2023.
//

import UIKit
extension ItemsTableViewController {
    
    func checkTextField() {
        if let alertController = alertController {
            if alertController.textFields?.first?.text?.isEmpty == true {
                alertController.actions.last!.isEnabled = false
            } else {
                alertController.actions.last!.isEnabled = true
            }
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        checkTextField()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkTextField()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkTextField()
    }
    
    
    @objc func setCurrencyName() {
        
        struct Currency {
            var currencyTitle: String
            var currencyString: String
            var imageSystamName: String
        }
        
        let choosePredefinedCurrencyAlertController = UIAlertController(title: "Choose currency", message: "or write below", preferredStyle: .alert)
        choosePredefinedCurrencyAlertController.addTextField()
        self.alertController = choosePredefinedCurrencyAlertController
        
        func setCurrencyIntoUserDefaults(currency: String) {
            UserDefaults.standard.setValue(NSString(string: currency), forKey: "currency")
            self.currency = currency
            self.tableView.reloadData()
        }
        
        //        Init action buttons with currencies
        
        func makeCurrencyAction(currency: Currency) -> UIAlertAction {
            let currencyAction = UIAlertAction(title: currency.currencyTitle, style: .default) { _ in
                setCurrencyIntoUserDefaults(currency: currency.currencyString)
            }
            currencyAction.setValue(UIImage(systemName: currency.imageSystamName), forKey: "image")
            return currencyAction
        }
        
        // List of currencies used in UIAlertController
        
        let currencyList = [Currency(currencyTitle: "US Dollar", currencyString: "USD", imageSystamName: "dollarsign.circle"),
        Currency(currencyTitle: "Euro", currencyString: "EUR", imageSystamName: "eurosign.circle"),
        Currency(currencyTitle: "Russian Ruble", currencyString: "RUR", imageSystamName: "rublesign.circle"),
        Currency(currencyTitle: "Georgian Lari", currencyString: "GEL", imageSystamName: "larisign.circle"),
        Currency(currencyTitle: "Japanese Yen", currencyString: "JPY", imageSystamName: "yensign.circle")]
        
        // Currency into UIAlertAction conversion
        
        let saveCurrencyAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            guard let currencyString = choosePredefinedCurrencyAlertController.textFields?.first?.text else {return}
            self.tableView.reloadData()
            print("currency saved")
            setCurrencyIntoUserDefaults(currency: currencyString)
        }
        
        
        //        Adding actions to alert controller
        
        choosePredefinedCurrencyAlertController.textFields?.first?.clearButtonMode = .whileEditing
        choosePredefinedCurrencyAlertController.textFields?.first?.delegate = self
        
        currencyList.forEach { currency in
            choosePredefinedCurrencyAlertController.addAction(makeCurrencyAction(currency: currency))
        }
        
        choosePredefinedCurrencyAlertController.addAction(saveCurrencyAction)
        
        //        Presenting alert controller
        
        present(choosePredefinedCurrencyAlertController, animated: true)
        
    }
    
    @objc func countItemsAlertController() {
        
        showSheetView(message: viewModel.resultString())
        
    }
    
}
