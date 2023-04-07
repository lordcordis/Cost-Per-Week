//
//  TableViewController.swift
//  Cost Per Week
//
//  Created by Wheatley on 28.10.2021.
//

import UIKit


class ItemsTableViewController: UITableViewController, UITextFieldDelegate {
    
    var alertController: UIAlertController?
    
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
        
        
        //        Adding actions to alert controller
        
        choosePredefinedCurrencyAlertController.textFields?.first?.clearButtonMode = .whileEditing
        
        choosePredefinedCurrencyAlertController.textFields?.first?.delegate = self
        
        choosePredefinedCurrencyAlertController.addAction(setDollarsAsCurrencyAction)
        choosePredefinedCurrencyAlertController.addAction(setEuroAsCurrencyAction)
        choosePredefinedCurrencyAlertController.addAction(setRubAsCurrencyAction)
        choosePredefinedCurrencyAlertController.addAction(setLariAsCurrencyAction)
        choosePredefinedCurrencyAlertController.addAction(saveCurrencyAction)
        
        //        Presenting alert controller
        
        present(choosePredefinedCurrencyAlertController, animated: true)
        
    }
    
    @objc func countItemsAlertController() {
        var currentSumForSingleWeek = 0
        var totalSum = 0
        
        for item in itemsForTableVC{
            let currentPriceForSingleWeek = item.pricePerWeek
            let currentPrice = item.price
            
            currentSumForSingleWeek += currentPriceForSingleWeek
            totalSum += currentPrice
        }
        
        
        let pricePerWeekString = "Per week: " + "\(currentSumForSingleWeek)" + " " + "\(UserDefaults.standard.value(forKey: "currency") ?? "RUB")"
        let priceTotalString = "All items: " + "\(totalSum)" + " " + "\(UserDefaults.standard.value(forKey: "currency") ?? "RUB")"
        
        let resultString = String("""
        \n
        \(pricePerWeekString) \n
        \(priceTotalString)
        \n
        """)
        
        let alert = UIAlertController(title: "Total cost", message: resultString, preferredStyle: .alert)
        let okActon = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okActon)
        present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // loading persisted data
        
        loadData()
        
                title = "CPW"
        view.backgroundColor = .systemGray6
        
        
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
        self.navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension ItemsTableViewController: retrieveItemDegelate {
    func editItem(item: Item) {
        itemsForTableVC[indexPathSelected!.row] = item
        saveData()
        tableView.reloadData()
    }
    
    
    func addItemToList(item: Item) {
        
        itemsForTableVC.append(item)
        saveData()
        self.tableView.reloadData()
    }
}
