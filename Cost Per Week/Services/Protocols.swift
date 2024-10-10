//
//  Delegates.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 21.07.2023.
//

import Foundation

protocol DismissDelegate {
    func dismiss()
}

protocol ChangeWeekOrDayInItemsTableViewDelegate: AnyObject {
    func refreshCurrency(currencyString: String)
    func refreshTitleAndReloadTableView()
}

protocol ItemTableViewDelegate: AnyObject {
    func addItemToList (item: Item)
    func editItem(item: Item)
    func deleteItem(item: Item)
}
