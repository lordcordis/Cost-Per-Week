//
//  TableViewController.swift
//  Cost Per Week
//
//  Created by Wheatley on 28.10.2021.
//

import UIKit


class TableViewController: UITableViewController, UITextFieldDelegate {
    
    var alertController: UIAlertController?
    
    func checkTextField() {
        if let alertController = alertController {
            if alertController.textFields?.first?.text?.isEmpty == true {
                alertController.actions[4].isEnabled = false
            } else {
                alertController.actions[4].isEnabled = true
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
    
    
    var itemsForTableVC = [Item]()
    
    var indexPathSelectedLast: Int?
    var indexPathSelected: IndexPath?
    
    @objc func createNewItem () {
        let detailVC = DetailViewController()
        detailVC.delegate = self
        self.navigationController?.present(detailVC, animated: true)
    }
    
    
    @objc func setCurrencyName() {
        let choosePredefinedCurrencyAlertController = UIAlertController(title: "Choose currency", message: "or write below", preferredStyle: .alert)
        choosePredefinedCurrencyAlertController.addTextField()
        self.alertController = choosePredefinedCurrencyAlertController
        
        func setCurrencyIntoUserDefaults(currency: String) {
            UserDefaults.standard.setValue(NSString(string: currency), forKey: "currency")
            self.tableView.reloadData()
        }
        
        //        Init action buttons with currencies
        
        let setDollarsAsCurrencyAction = UIAlertAction(title: "US Dollars", style: .default) { _ in
            setCurrencyIntoUserDefaults(currency: "dollars")
        }
        setDollarsAsCurrencyAction.setValue(UIImage(systemName: "dollarsign.circle"), forKey: "image")
        
        let setEuroAsCurrencyAction = UIAlertAction(title: "Euro", style: .default) { _ in
            setCurrencyIntoUserDefaults(currency: "euro")
        }
        setEuroAsCurrencyAction.setValue(UIImage(systemName: "eurosign.circle"), forKey: "image")
        
        let setRubAsCurrencyAction = UIAlertAction(title: "Russian Ruble", style: .default) { _ in
            setCurrencyIntoUserDefaults(currency: "rubles")
        }
        setRubAsCurrencyAction.setValue(UIImage(systemName: "rublesign.circle"), forKey: "image")
        
        let setLariAsCurrencyAction = UIAlertAction(title: "Lari", style: .default) { _ in
            setCurrencyIntoUserDefaults(currency: "lari")
        }
        setLariAsCurrencyAction.setValue(UIImage(systemName: "larisign.circle"), forKey: "image")
        
        
        let saveCurrencyAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            guard let currencyString = choosePredefinedCurrencyAlertController.textFields?.first?.text else {return}
            setCurrencyIntoUserDefaults(currency: currencyString)
        }
        saveCurrencyAction.isEnabled = true
        
        //        Adding actions to alert controller
        
        //        saveCurrencyAction.isEnabled = false
        
        
        choosePredefinedCurrencyAlertController.textFields?.first?.clearButtonMode = .whileEditing
        
        choosePredefinedCurrencyAlertController.textFields?.first?.delegate = self
        
        choosePredefinedCurrencyAlertController.addAction(setDollarsAsCurrencyAction)
        choosePredefinedCurrencyAlertController.addAction(setEuroAsCurrencyAction)
        choosePredefinedCurrencyAlertController.addAction(setRubAsCurrencyAction)
        choosePredefinedCurrencyAlertController.addAction(setLariAsCurrencyAction)
        choosePredefinedCurrencyAlertController.addAction(saveCurrencyAction)
        present(choosePredefinedCurrencyAlertController, animated: true)
        
    }
    
    @objc func countItems() {
        var currentSum = 0
        for item in itemsForTableVC{
            let current = item.pricePerWeek
            currentSum += current
        }
        let alert = UIAlertController(title: "Total cost of all items per week:", message: "\(currentSum) RUR", preferredStyle: .alert)
        let okActon = UIAlertAction(title: "ok honey", style: .cancel, handler: nil)
        alert.addAction(okActon)
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // loading persisted data
        
        loadData()
        
        title = "Cost per week"
        view.backgroundColor = .systemGray6
        
        
        // configuring navigation controller
        
        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .systemPink
        
        
        // configuring bar buttons
        
        let plusItem = UIBarButtonItem(image: .add, style: .done, target: self, action: #selector(createNewItem))
        
        let computeAllCostsItem = UIBarButtonItem(image: UIImage(systemName: "tray"), style: .plain, target: self, action: #selector(countItems))
        
        let settingsItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(setCurrencyName))
        
        
        //MARK: adding bar buttons
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = plusItem
        navigationController?.navigationBar.topItem?.leftBarButtonItems = [settingsItem, computeAllCostsItem]
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsForTableVC.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.tableView.register(ItemCellAnother.self, forCellReuseIdentifier: "itemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCellAnother
        cell.item = itemsForTableVC[indexPath.row]
        cell.configure()
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            itemsForTableVC.remove(at: indexPath.row)
            saveData()
            tableView.reloadData()
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.delegate = self
        detailVC.importedItem = itemsForTableVC[indexPath.row]
        indexPathSelectedLast = indexPath.row
        indexPathSelected = indexPath
        //        self.navigationController?.present(detailVC, animated: true, completion: nil)
        self.navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension TableViewController: retrieveItemDegelate {
    func editItem(item: Item) {
        //        print(indexPathSelectedLast! ?? "empty indexparthrow")
        //        itemsForTableVC.insert(item, at: indexPathSelected!.row)
        itemsForTableVC[indexPathSelected!.row] = item
        saveData()
        tableView.reloadData()
    }
    
    
    func addItemToList(item: Item) {
        
        itemsForTableVC.append(item)
        saveData()
        //        print(itemsForTableVC)
        self.tableView.reloadData()
    }
}
