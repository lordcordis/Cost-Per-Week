//
//  ItemCellSwiftUI.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 07.06.2023.
//

import SwiftUI

struct ItemCell: View {
    
    static let id = "ItemCellId"
    
    var item: Item
    var currency: String
    var delegate: ItemDelegate?
    let weekOrDayBool: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            ProductTitleView(item: item)
            Spacer()
            ProductPriceView(item: item, currency: currency, weekOrDayBool: weekOrDayBool)
        }.swipeActions {
            Button {
                delegate?.deleteItem(item: item)
            } label: {
                Label("Delete", systemImage: "trash")
            }
            .tint(.red)
        }
    }
}


struct ProductPriceView: View {
    var item: Item
    var currency: String
    let weekOrDayBool: Bool
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            
            if weekOrDayBool {
                Text(String(item.pricePerWeek))
                    .font(.system(.title, weight: .semibold))
                Text("\(currency) per week")
                    .foregroundStyle(.secondary)
                    .font(.system(.subheadline, weight: .bold))
            } else {
                Text(String(item.pricePerDay))
                    .font(.system(.title, weight: .semibold))
                Text("\(currency) per day")
                    .foregroundStyle(.secondary)
                    .font(.system(.subheadline, weight: .bold))
            }
            
            

        }
    }
}

struct ProductTitleView: View {
    var item: Item
    var body: some View {
        HStack {
            Label(item.name, systemImage: item.itemType.SystemImageName())
                .foregroundStyle(.pink)
                .font(.system(.subheadline, weight: .bold))
            Spacer()
            Text(item.date, style: .date)
                .foregroundStyle(.secondary)
                .font(.footnote)
        }
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell(item: Item.sampleItem, currency: "USD", delegate: nil, weekOrDayBool: false)
    }
}
