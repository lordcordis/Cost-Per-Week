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
        
        let july2010 = Date(timeIntervalSince1970: 1277942400)
        let july15_2020 = Date(timeIntervalSince1970: 1594771200)
        let june2016 = Date(timeIntervalSince1970: 1464739200)
        
        var yamahaAddons: [ItemAddon] = [
            ItemAddon(description: "Roland Micro Cube", price: 4500, id: UUID().uuidString)
        ]
        
        let sampleItems: [Item] = [
            Item(name: "Yamaga", date: july2010, addonsActive: false, addons: yamahaAddons, itemType: .undefined, id: UUID().uuidString, isSold: false, dateSold: Date(), priceSold: 100)
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

