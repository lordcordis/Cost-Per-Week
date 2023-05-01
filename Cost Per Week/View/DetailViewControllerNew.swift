//
//  DetailViewControllerNew.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 14.04.2023.
//

import UIKit

class DetailViewControllerNew: UITableViewController {
    
    
    
    let cells = [["cell", "cell 2"], ["cell 3", "cell 4", "cell 5"], ["cell 6"], ["cell 7", "cell 8"]]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return cells.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "Label"
        } else {
            return nil
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cells[section].count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: "2")
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "2", for: indexPath) as! TextFieldTableViewCell
        var config = cell.defaultContentConfiguration()
        
        config.text = cells[indexPath.section][indexPath.row]
        cell.contentConfiguration = config
        
        cell.selectionStyle = .none
        cell2.selectionStyle = .none
        
        if indexPath.section == 0 {
            cell.accessoryView = UISwitch()
            return cell
        }
        
        
        else if indexPath.section == 1 {
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .date
            cell.accessoryView = datePicker
            return cell
        }
        else if indexPath.section == 2 {
            cell2.configure()
            return cell2
        }
        else if indexPath.section == 3 {
            cell2.configure()
            return cell2
        }
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
