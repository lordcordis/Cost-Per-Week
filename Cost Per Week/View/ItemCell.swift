//
//  TableViewCell.swift
//  Cost Per Week
//
//  Created by Wheatley on 28.10.2021.
//

import UIKit

class ItemCell: UITableViewCell {
    
    static let id = "ItemCell"
    
    var item: Item!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // labels' initialisation
    
    let itemNameLabel = UILabel()
    let itemPurchasedDateLabel = UILabel()
    let itemCostPerWeekLabel = UILabel()
    
    // initial configuration of the cell
    
    func configure() {
        
        
        
        // adding labels to subview
        
        contentView.addSubview(itemNameLabel)
        contentView.addSubview(itemPurchasedDateLabel)
        contentView.addSubview(itemCostPerWeekLabel)
        
        
        
        // making labels ready for autolayout
        
        self.itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.itemPurchasedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.itemCostPerWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        //  configuring labels
        
        initConstraints()
        fillLabelsWithInfo()
    }
    
    
    // laying out constraints
    
    func initConstraints() {
        itemNameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        itemNameLabel.adjustsFontForContentSizeCategory = true
        itemPurchasedDateLabel.font = UIFont.preferredFont(forTextStyle: .body)
        itemPurchasedDateLabel.adjustsFontForContentSizeCategory = true
        itemCostPerWeekLabel.font = UIFont.preferredFont(forTextStyle: .body)
        itemCostPerWeekLabel.adjustsFontForContentSizeCategory = true
        
        let constraints: [NSLayoutConstraint] = [
            
            // autolayout for labels using layoutMarginsGuide
            
            itemNameLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            itemNameLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            itemNameLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: contentView.layoutMarginsGuide.topAnchor, multiplier: 1),
            
            itemPurchasedDateLabel.leadingAnchor.constraint(equalTo: itemNameLabel.leadingAnchor),
            itemPurchasedDateLabel.trailingAnchor.constraint(equalTo: itemNameLabel.trailingAnchor),
            itemPurchasedDateLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: itemNameLabel.lastBaselineAnchor, multiplier: 2),
            
            itemCostPerWeekLabel.leadingAnchor.constraint(equalTo: itemNameLabel.leadingAnchor),
            itemCostPerWeekLabel.trailingAnchor.constraint(equalTo: itemNameLabel.trailingAnchor),
            itemCostPerWeekLabel.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: itemPurchasedDateLabel.lastBaselineAnchor, multiplier: 1),
            
            
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: itemCostPerWeekLabel.lastBaselineAnchor, multiplier: 1)
            
            
            
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
    // populating labels with info
    
    func fillLabelsWithInfo() {
        itemNameLabel.text = item.name
        itemPurchasedDateLabel.text = item.dateAsString
        itemCostPerWeekLabel.text = "\(item.pricePerWeek)" + " " + "\(UserDefaults.standard.string(forKey: "currency") ?? "RUB") per week"
    }
}
