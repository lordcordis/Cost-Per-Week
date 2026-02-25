//
//  ItemCellSwiftUI.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 07.06.2023.
//

import SwiftUI

struct ItemCellView: View {
    
    var viewModel: ItemCellViewModel
    static let id = "ItemCellId"
    
    var body: some View {
        HStack(spacing: 16) {
            // Item Type Icon
            Image(systemName: viewModel.systemImageName()) // Use your custom image if needed
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(Color.pink) // Customize the color
            
            VStack(alignment: .leading, spacing: 4) {
                // Item Name
                Text(viewModel.name())
                    .font(.headline)
                    .foregroundColor(.primary)
                
                // Date of Purchase
                Text(viewModel.dateString())
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                if viewModel.shouldShowSoldData() {
                    
                    Text(viewModel.timeOwnedInterval())
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            VStack {
                
                switch viewModel.weekOrDay() {
                case .week:
                    Text(viewModel.pricePerWeek())
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.pink)
                    
                    Text("\(viewModel.currencyString()) per week")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                case .day:
                    Text(viewModel.pricePerDay())
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.pink)
                    
                    Text("\(viewModel.currencyString()) per day")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6)) // Light gray background for the cell
        .cornerRadius(12)
        .shadow(radius: 1)
    }
}

struct ItemCell: View {
    
    var viewModel: ItemCellViewModel
    
    static let id = "ItemCellId"
    
    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                ProductTitleView(viewModel: viewModel)
                Spacer()
                ProductPriceView(viewModel: viewModel)
            }
            
            VStack {
                
                if viewModel.shouldShowSoldData() {
                    Text(viewModel.dateString())
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                    
                    Text(viewModel.dateSoldString())
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                    
                    Spacer()
                    
                    Text(viewModel.timeOwnedInterval())
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                } else {
                    Text(viewModel.dateString())
                        .foregroundStyle(.secondary)
                        .font(.footnote)
                    
                    Spacer()
                }
            }
        }
    }
}

struct ProductPriceView: View {
    
    let viewModel: ItemCellViewModel
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            
            switch viewModel.weekOrDay() {
            case .week:
                Text(viewModel.pricePerWeek())
                    .font(.system(.title, weight: .semibold))
                Text("\(viewModel.currencyString()) per week")
                    .foregroundStyle(.secondary)
                    .font(.system(.subheadline, weight: .bold))
            case .day:
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
        }
    }
}

#Preview {
    ItemCellView(
        viewModel: ItemCellViewModel(
            item: Item(
                name: "Test",
                date: Date(),
                addonsActive: false,
                addons: [],
                itemType: .airpods,
                id: "22",
                isSold: false,
                dateSold: Date(),
                priceSold: Int(200.0)
            ),
            delegate: nil,
            weekOrDay: false
        )
    )
}
