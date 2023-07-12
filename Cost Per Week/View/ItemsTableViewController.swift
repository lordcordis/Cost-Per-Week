//
//  TableViewController.swift
//  Cost Per Week
//
//  Created by Wheatley on 28.10.2021.
//

import UIKit
import Combine
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
    
    var currency = "\(UserDefaults.standard.value(forKey: "currency") ?? "RUR")"
    
    
    // Setting up diffable data source and cells
    
    func setupDataSource() {
        
        dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.id)
            
            // creating cell contents with SwiftUI
            // TODO: Implement CellViewModel
            cell?.contentConfiguration = UIHostingConfiguration {
                ItemCell(item: item, currency: self.currency, delegate: self)
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
//        let detailVC = DetailViewController()
//        detailVC.delegate = self
//        self.navigationController?.present(detailVC, animated: true)
        
        
        showDetailView(indexPath: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        checkIfItemsListIsEmpty()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ItemCell.id)
        tableView.delegate = self
        setupDataSource()
        updateDataSource()
        title = viewModel.viewTitle()
        view.backgroundColor = .systemGray6
        configureNavigationController()

    }
    
    
    // MARK: - Providing swiftUI Detail View in a UIHostingController
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        guard let item = dataSource.itemIdentifier(for: indexPath) else {return}
//        var rootView = DetailView(item: item)
//        rootView.delegate = self
//        rootView.dismissDelegate = self
//        let detailVC = UIHostingController(rootView: rootView)
//        self.navigationController?.pushViewController(detailVC, animated: true)
//        tableView.deselectRow(at: indexPath, animated: true)
        
        showDetailView(indexPath: indexPath)
        
    }
    
    func showDetailView(indexPath: IndexPath?) {
        
        if let indexPath = indexPath, let item = dataSource.itemIdentifier(for: indexPath) {
            var rootView = DetailView(item: item)
            rootView.delegate = self
            rootView.dismissDelegate = self
            let detailVC = UIHostingController(rootView: rootView)
            self.navigationController?.pushViewController(detailVC, animated: true)
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            var rootView = DetailView()
            rootView.delegate = self
            rootView.dismissDelegate = self
            let detailVC = UIHostingController(rootView: rootView)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
            
            
            

    }
}

//MARK: - realisation of ItemDelegate protocol

extension ItemsTableViewController: ItemDelegate {
    
    
    func deleteItem(item: Item) {
        viewModel.removeItemDiff(item: item)
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([item])
        dataSource.apply(snapshot)
        checkIfItemsListIsEmpty()
    }
    
    
    func editItem(item: Item) {
        viewModel.updateItemDiff(item: item)
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

//MARK: - Realisation of DismissDelegate protocol

extension ItemsTableViewController: DismissDelegate {
    
    func dismiss() {
        self.navigationController?.popViewController(animated: true)
    }
}
