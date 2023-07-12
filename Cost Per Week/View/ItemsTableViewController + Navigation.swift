//
//  File.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 08.07.2023.
//

import Foundation
import UIKit
extension ItemsTableViewController {
    func configureNavigationController() {
        
        // configuring navigation controller
        
        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .systemPink
        
        
        // configuring bar buttons
        
        let plusItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: #selector(createNewItem))
        
        let computeAllCostsItem = UIBarButtonItem(image: UIImage(systemName: "tray"), style: .plain, target: self, action: #selector(countItemsAlertController))
        
        let settingsItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(setCurrencyName))
        
        
        //MARK: adding bar buttons to navigation bar
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = plusItem
        navigationController?.navigationBar.topItem?.leftBarButtonItems = [settingsItem, computeAllCostsItem]
        
    }
}
