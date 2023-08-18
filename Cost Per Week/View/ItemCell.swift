//
//  ItemCellSwiftUI.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 07.06.2023.
//

import SwiftUI

struct ItemCell: View {
    
    var viewModel: ItemCellViewModel
    
    static let id = "ItemCellId"
    
    var body: some View {
        VStack(alignment: .leading) {
            ProductTitleView(viewModel: viewModel)
            Spacer()
            ProductPriceView(viewModel: viewModel)
        }.swipeActions {
            Button {
                viewModel.deleteCurrentItem()
            } label: {
                Label("Delete", systemImage: "trash")
            }
            .tint(.red)
        }
    }
}


struct ProductPriceView: View {

    let viewModel: ItemCellViewModel
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            
            if viewModel.weekOrDay() {
                Text(viewModel.pricePerWeek())
                    .font(.system(.title, weight: .semibold))
                Text("\(viewModel.currencyString()) per week")
                    .foregroundStyle(.secondary)
                    .font(.system(.subheadline, weight: .bold))
            } else {
                Text(viewModel.pricePerDay())
                    .font(.system(.title, weight: .semibold))
                Text("\(viewModel.currencyString()) per day")
                    .foregroundStyle(.secondary)
                    .font(.system(.subheadline, weight: .bold))
            }
        }
    }
}

struct ProductTitleView: View {
    
    let viewModel: ItemCellViewModel
    
    var body: some View {
        HStack {
            Label(viewModel.name(), systemImage: viewModel.systemImageName())
                .foregroundStyle(.pink)
                .font(.system(.subheadline, weight: .bold))
            Spacer()
            Text(viewModel.dateString())
                .foregroundStyle(.secondary)
                .font(.footnote)
        }
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell(viewModel: ItemCellViewModel(item: Item.sampleItem, delegate: nil, weekOrDay: false))
    }
}
