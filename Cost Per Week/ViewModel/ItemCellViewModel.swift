//
//  ItemCellViewModel.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 17.08.2023.
//

import Foundation

class ItemCellViewModel {
    
    private let item: Item
    private let currency: Currency
    weak var delegate: ItemTableViewDelegate?
    private let weekOrDayBool: Bool
    
    init(item: Item, delegate: ItemTableViewDelegate?, weekOrDay: Bool) {
        self.item = item
        self.delegate = delegate
        self.weekOrDayBool = weekOrDay
        
        let currencyString = CurrencyObject.currencyString()
        currency = Currency.stringIntoCurrencyObject(currencyString: currencyString)
    }
    
    func dateString() -> String {
        return item.dateAsString
    }
    
    func weekOrDay() -> Bool {
        return weekOrDayBool
    }
    
    func name() -> String {
        return item.name
    }
    
    func systemImageName() -> String {
        return item.itemType.SystemImageName()
    }
    
    func pricePerDay() -> String {
        return String(item.pricePerDay)
    }

    func pricePerWeek() -> String {
        return String(item.pricePerWeek)
    }
    
    func currencyString() -> String{
        return currency.rawValue
    }
    
    func deleteCurrentItem() {
        delegate?.deleteItem(item: item)
    }
    
    func rubleString(for amount: Int) -> String {
        let remainder10 = amount % 10
        let remainder100 = amount % 100

        var rubleWord: String

        if remainder100 >= 11 && remainder100 <= 19 {
            rubleWord = "рублей"
        } else {
            switch remainder10 {
            case 1:
                rubleWord = "рубль"
            case 2, 3, 4:
                rubleWord = "рубля"
            default:
                rubleWord = "рублей"
            }
        }

        return "\(amount) \(rubleWord)"
    }
    
    func rubleStringPerDay() -> String {
        rubleString(for: item.pricePerDay)
    }
    
    func rubleStringPerWeek() -> String {
        rubleString(for: item.pricePerWeek)
    }
}
