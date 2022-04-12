//
//  TableViewController.swift
//  Cost Per Week
//
//  Created by Wheatley on 28.10.2021.
//

import UIKit

class TableViewController: UITableViewController {

    var itemsForTableVC = [Item]()
    
    var indexPathSelectedLast: Int?
    var indexPathSelected: IndexPath?
    
    @objc func createNewItem () {
        let detailVC = DetailViewController()
        detailVC.delegate = self
        self.navigationController?.present(detailVC, animated: true)
    }

    
    @objc func countItems(){
        
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
        
        loadData()
        
        title = "Cost per week"
        view.backgroundColor = .systemGray6
        
        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .systemPink
        
        let plusItem = UIBarButtonItem(image: .add, style: .done, target: self, action: #selector(createNewItem))
        
        let computeAllCostsItem = UIBarButtonItem(image: UIImage(systemName: "tray"), style: .plain, target: self, action: #selector(countItems))
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = plusItem
        navigationController?.navigationBar.topItem?.leftBarButtonItem = computeAllCostsItem
        
        
        
        

        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = true

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        self.view.backgroundColor = .lightGray
//
//        self.tableView.rowHeight = UITableView.automaticDimension
//        self.tableView.estimatedRowHeight = 200
        

//        self.tableView.estimatedRowHeight = 100
//        self.tableView.rowHeight = UITableView.automaticDimension
//        
        
    }

    // MARK: - Table view data source
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemsForTableVC.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.tableView.register(ItemCellAnother.self, forCellReuseIdentifier: "itemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCellAnother

//        cell.configure()
//        let v = cell.contentView
//        v.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
//
        cell.item = itemsForTableVC[indexPath.row]
        cell.configure()
        
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        return UITableView.automaticDimension
//        return 200
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
