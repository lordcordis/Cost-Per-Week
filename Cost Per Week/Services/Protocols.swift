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

protocol ChangeWeekOrDayInItemsTableViewDelegate {
    func refreshCurrency(currencyString: String)
    func refreshTitle()
}

protocol ItemTableViewDelegate: AnyObject {
    func addItemToList (item: Item)
    func editItem(item: Item)
    func deleteItem(item: Item)
}
