//
//  Persistency.swift
//  Cost Per Week
//
//  Created by Wheatley on 27.10.2021.
//

import Foundation

final class PersistenceManager {
    
    func documentsFolder() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func savePath() -> URL {
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

extension PersistenceManager {
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

extension PersistenceManager {
    /// Append a new item to the persisted plist.
    @discardableResult
    func addItem(_ item: Item) -> Bool {
        var items = retreveData() ?? []
        items.append(item)
        saveData(items: items)
        return true
    }

    /// Convenience: replace an item entirely by passing the updated instance.
    /// The `updatedItem.id` is used to locate the existing entry.
    @discardableResult
    func updateItem(_ updatedItem: Item) -> Bool {
        guard var items = retreveData() else {
            print("No existing data to update.")
            return false
        }
        guard let idx = items.firstIndex(where: { $0.id == updatedItem.id }) else {
            print("Item with id \(updatedItem.id) not found.")
            return false
        }
        items[idx] = updatedItem
        saveData(items: items)
        return true
    }
}
