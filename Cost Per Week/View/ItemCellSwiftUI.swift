//
//  ItemCellSwiftUI.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 07.06.2023.
//

import SwiftUI

struct ItemView: View {
    
    var item: Item
    var currency: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HeartRateTitleView(item: item)
            Spacer()
            HeartRateBPMView(item: item, currency: currency)
        }
    }
}


struct HeartRateBPMView: View {
    var item: Item
    var currency: String
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(String(item.pricePerWeek))
                .font(.system(.title, weight: .semibold))
            Text("\(currency) per week")
                .foregroundStyle(.secondary)
                .font(.system(.subheadline, weight: .bold))
        }
    }
}

struct HeartRateTitleView: View {
    var item: Item
    var body: some View {
        HStack {
            Label(item.name, systemImage: "iphone")
                .foregroundStyle(.pink)
                .font(.system(.subheadline, weight: .bold))
            Spacer()
            Text(item.date, style: .date)
                .foregroundStyle(.secondary)
                .font(.footnote)
        }
    }
}
