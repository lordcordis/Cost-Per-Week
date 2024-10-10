//
//  Persistency.swift
//  Cost Per Week
//
//  Created by Wheatley on 27.10.2021.
//

import Foundation

class Persistency {
    func documentsFolder()-> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func savePath()-> URL {
        return documentsFolder().appendingPathComponent("data.plist")
    }
    
    func retreveData() -> [Item]? {
        do {
            let retrievedData = try Data(contentsOf: savePath())
            let plistDec = PropertyListDecoder()
            let itemData = try plistDec.decode([Item].self, from: retrievedData)
            return itemData
        } catch {
            print("error loading data from plist")
            return nil
        }
    }
    
    func saveData(items: [Item]){
        do {
            let plistEnc = PropertyListEncoder()
            let savedata = try plistEnc.encode(items)
            try savedata.write(to: savePath())
            print("data saved")
        } catch {
            print("error saving data")
        }
    }
    
    
    enum KeysForUserDefaults: String {
        case currency, pricePerWeekIfTrue
    }
}

extension Persistency {
    func deleteAllData() {
        do {
            let items = [Item]()
            let plistEnc = PropertyListEncoder()
            let savedata = try plistEnc.encode(items)
            try savedata.write(to: savePath())
            print("data saved")
        } catch {
            print("error saving data")
        }
    }
}
