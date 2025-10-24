//
//  File.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 08.07.2023.
//

import Foundation
import UIKit
extension ItemsTableViewController {
    
    @objc func showSettings() {
        showSettings()
    }
    
    @objc func countItemsAlertController() {
        showSheetAsHosted(message: viewModel.pricePerWeekOrDayStringOutput(), message2: viewModel.totalPriceStringOutput())
    }
    
    func configureNavigationController() {
        
        // configuring navigation controller
        
        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .systemPink
        
        // configuring bar buttons
        
        let plusItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: #selector(createNewItem))
        
        let computeAllCostsItem = UIBarButtonItem(image: UIImage(systemName: "tray"), style: .plain, target: self, action: #selector(countItemsAlertController))
        
        let settingsItem = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(showSettings))
        
        // MARK: adding bar buttons to navigation bar
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = plusItem
        navigationController?.navigationBar.topItem?.leftBarButtonItems = [settingsItem, computeAllCostsItem]
        
    }
}
