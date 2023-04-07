//
//  Persistency.swift
//  Cost Per Week
//
//  Created by Wheatley on 27.10.2021.
//

import Foundation

extension ItemsTableViewController {
    func documentsFolder()-> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func savePath()-> URL {
        return documentsFolder().appendingPathComponent("data.plist")
    }
    
    
    
    func saveData(){
        do {
            let plistEnc = PropertyListEncoder()
            let savedata = try plistEnc.encode(itemsForTableVC)
            try savedata.write(to: savePath())
            print("data saved")
        } catch {
            print("error saving data")
        }
    }
    
    func loadData(){
        
        do {
            let retrievedData = try Data(contentsOf: savePath())
            let plistDec = PropertyListDecoder()
            let itemData = try plistDec.decode([Item].self, from: retrievedData)
            self.itemsForTableVC = itemData
            
//            print("data loaded")
        } catch {
            print("error loading data")
        }
        
    }
}
