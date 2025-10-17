//
//  AppDelegate.swift
//  Cost Per Week
//
//  Created by Wheatley on 27.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        let needshardReset = true
        let needshardReset = false
        
        let nswPurchaseDate = Date(timeIntervalSince1970: 1488518400)
        let nswSoldDate = Date(timeIntervalSince1970: 1636940800)
        let airpodsProPurchaseDate = Date(timeIntervalSince1970: 1594771200)
        let macbookPurchaseDate = Date(timeIntervalSince1970: 1464739200)
        let watch7purchaseDate = Date(timeIntervalSince1970: 1640044800)
        
        let yamahaPurchaseDate = Date(timeIntervalSince1970: 1277942400)
        
        let switchAddons = [
            ItemAddon(description: "Case", price: 1700, id: UUID().uuidString),
            ItemAddon(description: "Pro Controller", price: 3900, id: UUID().uuidString)
        ]
        
        let macbookAddons = [
            ItemAddon(description: "Battery", price: 4200, id: UUID().uuidString),
            ItemAddon(description: "Battery", price: 3000, id: UUID().uuidString),
        ]
        
        let yamahaAddons: [ItemAddon] = [
            ItemAddon(description: "Roland Micro Cube", price: 4500, id: UUID().uuidString),
            ItemAddon(description: "Digitech RP155", price: 6100, id: UUID().uuidString)
        ]
        
        let airpodsAddons = [
            ItemAddon(description: "Case", price: 6000, id: UUID().uuidString)
        ]
        
        let sampleItems: [Item] = [
            Item(name: "Yamaha RG121z", price: 21000, date: yamahaPurchaseDate, addonsActive: true, addons: yamahaAddons, itemType: .musicInstrument, id: UUID().uuidString, isSold: false, dateSold: Date(), priceSold: 100),
            Item(name: "AirPods Pro", price: 14000, date: airpodsProPurchaseDate, addonsActive: true, addons: airpodsAddons, itemType: .airpods, id: UUID().uuidString, isSold: false, dateSold: Date(), priceSold: 100),
            Item(name: "Nintendo Switch", price: 25000, date: nswPurchaseDate, addonsActive: true, addons: switchAddons, itemType: .console, id: UUID().uuidString, isSold: true, dateSold: nswSoldDate, priceSold: 20000),
            Item(name: "MacBook Pro 13 2015 128GB", price: 82000, date: macbookPurchaseDate , addonsActive: true, addons: macbookAddons, itemType: .macbook, id: UUID().uuidString, isSold: false, dateSold: Date(), priceSold: 0),
            Item(name: "Apple Watch Series 7", price: 41000, date: watch7purchaseDate , addonsActive: false, addons: [], itemType: .appleWatch, id: UUID().uuidString, isSold: false, dateSold: Date(), priceSold: 0)
        ]
        
        if needshardReset {
            let presistency = Persistency()
            presistency.deleteAllData()
            presistency.saveData(items: sampleItems)
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
