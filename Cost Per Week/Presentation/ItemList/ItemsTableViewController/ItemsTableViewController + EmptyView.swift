//
//  ItemsTableViewController + EmptyView.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 07.06.2023.
//

import Foundation
import UIKit

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

extension ItemsTableViewControllerViewModel {
    
    // MARK: - Generating view in case of absence of items
        
        func generateEmptyListView () -> UIView {
            let errorView = UIView()
            errorView.tag = ItemsTableViewController.TagForView.errorView.rawValue
            let roundedView = UIView()
            errorView.addSubview(roundedView)
            roundedView.backgroundColor = .systemBackground
            roundedView.layer.cornerRadius = 10
            roundedView.translatesAutoresizingMaskIntoConstraints = false
            
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 1
            label.textAlignment = .center
            label.text = "Add an item"
            errorView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: errorView.centerYAnchor)
            ])

            NSLayoutConstraint.activate([
                roundedView.widthAnchor.constraint(equalTo: label.widthAnchor, constant: 20),
                roundedView.heightAnchor.constraint(equalTo: label.heightAnchor, constant: 20),
                roundedView.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
                roundedView.centerYAnchor.constraint(equalTo: errorView.centerYAnchor)
            ])
            
            errorView.backgroundColor = .secondarySystemBackground
            return errorView
        }
}
