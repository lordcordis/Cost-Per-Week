//
//  TableViewController.swift
//  Cost Per Week
//
//  Created by Wheatley on 28.10.2021.
//

import UIKit
import SwiftUI

class ItemsTableViewController: UITableViewController, UITextFieldDelegate {
    
    //    Initialisation
    
    init(model: ItemsTableViewControllerViewModel) {
        self.viewModel = model
        self.isErrorViewShown = viewModel.isEmpty()
        self.tableViewIsEmptyView = viewModel.generateEmptyListView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    Initialising datasource, view model and alert controller
    
    private var dataSource: UITableViewDiffableDataSource <Int, Item>!
    
    var viewModel: ItemsTableViewControllerViewModel
    
    var alertController: UIAlertController?
    
    var tableViewIsEmptyView: UIView
    
    var isErrorViewShown: Bool {
        didSet{
            switch isErrorViewShown {
            case false: deleteEmptyMessage()
            case true: showEmptyMessage()
            }
        }
    }
    
//    var currency: String = CurrencyObject.currencyString()
    
    // Setting up diffable data source and cells
    
    func setupDataSource() {
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { [self] tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemCellView.id)
            
            // creating cell contents with SwiftUI
            
            let viewModel = ItemCellViewModel(item: item, delegate: self, weekOrDay: viewModel.weekOrDayBool)
            
            cell?.contentConfiguration = UIHostingConfiguration {
                ItemCellView(viewModel: viewModel)
            }
            return cell
        })
    }
    
    func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot <Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.allItems(), toSection: 0)
        dataSource.apply(snapshot)
    }
    
    @objc func createNewItem () {
        showDetailView(indexPath: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfItemsListIsEmpty()
        title = viewModel.viewTitle()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ItemCell.id)
        tableView.delegate = self
        setupDataSource()
        updateDataSource()
        view.backgroundColor = .systemGray6
        configureNavigationController()

    }
    
    // MARK: - Providing swiftUI Detail View in a UIHostingController
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        showDetailView(indexPath: indexPath)
        
    }
    
//    showing empty or filled detail view (if indexPath is present)
    
    func showDetailView(indexPath: IndexPath?) {
        
        if let indexPath = indexPath, let item = dataSource.itemIdentifier(for: indexPath) {
            
            let viewModel = DetailViewModel(item: item, delegate: self, dismissDelegate: self, systemCurrencyString: viewModel.currencyStringIntoSystemImageName())
            let rootView = DetailView(viewModel: viewModel)

            let detailVC = UIHostingController(rootView: rootView)
            self.navigationController?.pushViewController(detailVC, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
      
            let viewModel = DetailViewModel(item: nil, delegate: self, dismissDelegate: self, systemCurrencyString: viewModel.currencyStringIntoSystemImageName())
            let rootView = DetailView(viewModel: viewModel)
            
            let detailVC = UIHostingController(rootView: rootView)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

//nMARK: - realisation of ItemDelegate protocol: deleting, editing, adding items

extension ItemsTableViewController: ItemTableViewDelegate {
    
    func deleteItem(item: Item) {
        viewModel.removeItem(item: item)
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([item])
        dataSource.apply(snapshot)
        checkIfItemsListIsEmpty()
    }
    
    func editItem(item: Item) {
        viewModel.updateItem(item: item)
        var snapshot = dataSource.snapshot()
        snapshot.deleteAllItems()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.allItems())
        dataSource.apply(snapshot)
        checkIfItemsListIsEmpty()
        
    }
    
    
    func addItemToList(item: Item) {
        viewModel.appendItem(item: item)
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([item])
        dataSource.apply(snapshot)
        checkIfItemsListIsEmpty()
    }
}

// MARK: - Realisation of DismissDelegate protocol: ability to pop view from navigation controller from swiftui view

extension ItemsTableViewController: DismissDelegate {
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
}
