//
//  ItemsTableViewController + EmptyView.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 07.06.2023.
//

import Foundation

extension ItemsTableViewController {
    
    enum TagForView: Int {
        case errorView = 44
    }
    
    // Checking if item list is empty and showing a view with "add items" message"
    
    func checkIfItemsListIsEmpty() {
        if viewModel.isEmpty() {
            showEmptyMessage()
        } else {
            deleteEmptyMessage()
        }
    }
    
    //    Initialising view with message and presenting it
    
    func showEmptyMessage() {
        
        view.addSubview(tableViewIsEmptyView)
        tableViewIsEmptyView.translatesAutoresizingMaskIntoConstraints = false
        tableViewIsEmptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableViewIsEmptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        
    }
    
//    Deleting view
    
    func deleteEmptyMessage() {
        
        tableViewIsEmptyView.removeFromSuperview()
    }
}
