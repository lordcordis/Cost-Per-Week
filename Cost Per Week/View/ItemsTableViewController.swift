//
//  TableViewController.swift
//  Cost Per Week
//
//  Created by Wheatley on 28.10.2021.
//

import UIKit
import Combine
import SwiftUI


class ItemsTableViewController: UITableViewController, UITextFieldDelegate{
    
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
            
            
            cell?.contentConfiguration = UIHostingConfiguration {
                ItemView(item: item, currency: self.currency)
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
        
        //        showMyViewControllerInACustomizedSheet()
        
        
        
        let detailVC = DetailViewController()
        detailVC.delegate = self
        
        //
        //
        //        let sheet = UISheetPresentationController(presentedViewController: self, presenting: detailVC)
        //        self.navigationController?.present(sheet, animated: true)
        //
        //
        //
        //        let detailVC = DetailViewController()
        //        detailVC.navigationController?.isNavigationBarHidden = false
        //        detailVC.delegate = self
        
        
        self.navigationController?.present(detailVC, animated: true)
    }
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        checkIfItemsListIsEmpty()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.id)
        tableView.delegate = self
        setupDataSource()
        updateDataSource()
        //        check()
        //        addToolbar()
        
        
        
        //        tableView.isHidden = true
        
        
        
        
        //        let label = UILabel()
        //        label.text = "sample"
        //        tableView.isHidden = true
        //        label.frame = tableView.bounds
        //        tableView.addSubview(label)
        //        view.backgroundColor = .systemBlue
        
        
        // loading persisted data
        
        //        loadData()
        
        title = viewModel.viewTitle()
        view.backgroundColor = .systemGray6
        configureNavigationController()
        
        
        
    }
    
    //    func check() {
    //        let snapshot = dataSource.snapshot()
    ////        printContent(snapshot.itemIdentifiers)
    //        if snapshot.itemIdentifiers.isEmpty {
    //            print("empty")
    //        }
    //
    //    }
    
    
    
    func configureNavigationController() {
        // configuring navigation controller
        
        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .systemPink
        
        
        // configuring bar buttons
        
        let plusItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: #selector(createNewItem))
        
        let computeAllCostsItem = UIBarButtonItem(image: UIImage(systemName: "tray"), style: .plain, target: self, action: #selector(countItemsAlertController))
        
        let settingsItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(setCurrencyName))
        
        
        
        //MARK: adding bar buttons
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = plusItem
        navigationController?.navigationBar.topItem?.leftBarButtonItems = [settingsItem, computeAllCostsItem]
        
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCell.id, for: indexPath) as! ItemCell
        cell.item = viewModel.itemForIndexPath(indexpath: indexPath)
        cell.configure()
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        print("\(indexPath) is editing Y")
        
        
        if (editingStyle == .delete) {
            //            viewModel.removeItem(at: indexPath)
            //            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            print("\(indexPath) is editing")
            
            
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {return}
        let detailVC = DetailViewController()
        detailVC.delegate = self
        detailVC.importedItem = item
        self.navigationController?.pushViewController(detailVC, animated: true)
        print(item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

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
    
    
    
    
    
    
    //    func showMyViewControllerInACustomizedSheet() {
    //
    //
    //
    //
    //
    //        let viewControllerToPresent = DetailViewControllerNew(style: .insetGrouped)
    ////        viewControllerToPresent.delegate = self
    //        if let sheet = viewControllerToPresent.sheetPresentationController {
    ////            sheet.presentedViewController.navigationController?.navigationBar.backgroundColor = .systemPink
    //            sheet.detents = [.medium(), .large()]
    //            sheet.largestUndimmedDetentIdentifier = .none
    //            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
    //            sheet.prefersEdgeAttachedInCompactHeight = true
    //            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
    //            sheet.prefersGrabberVisible = true
    //            sheet.preferredCornerRadius = 20
    //        }
    //        present(viewControllerToPresent, animated: true, completion: nil)
    //    }
}

