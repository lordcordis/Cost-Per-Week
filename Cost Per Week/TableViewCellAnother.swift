//
//  TableViewCell.swift
//  Cost Per Week
//
//  Created by Wheatley on 28.10.2021.
//

import UIKit

class ItemCellAnother: UITableViewCell {
    
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
        
        
        
        self.itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.itemPurchasedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.itemCostPerWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(itemNameLabel)
        addSubview(itemPurchasedDateLabel)
        addSubview(itemCostPerWeekLabel)
        
        initConstraints()
        fillLabelsWithInfo()

        contentView.sizeToFit()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // nothing here but us chickens
        
    }
    
    func initConstraints() {
        
        let constraints: [NSLayoutConstraint] = [
            
            itemNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            itemNameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            itemPurchasedDateLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 20),
            itemPurchasedDateLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            itemCostPerWeekLabel.topAnchor.constraint(equalTo: itemPurchasedDateLabel.bottomAnchor, constant: 20),
            itemCostPerWeekLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
//            contentView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: itemCostPerWeekLabel.bottomAnchor, constant: -20)
            
            
            
            contentView.heightAnchor.constraint(equalToConstant: 150),
            
            
        ]
        NSLayoutConstraint.activate(constraints)
        
//        let heightForThisCell: CGFloat = 80 + itemCostPerWeekLabel.heightAnchor
        
    }
    
    func fillLabelsWithInfo() {
        itemNameLabel.text = item.name
        itemPurchasedDateLabel.text = item.dateAsString
        itemCostPerWeekLabel.text = "\(item.pricePerWeek) rubles per week"
    }
    
    
    
    
}
