//
//  TableViewCell.swift
//  Cost Per Week
//
//  Created by Wheatley on 28.10.2021.
//

import UIKit

class ItemCell: UITableViewCell {
    
    var item: Item!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        //        self.backgroundColor = .yellow
        initItemNameLabel()
        initPurchasedDateLabel()
        initCostPerWeekLabel()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //        print(item ?? "what")
    }
    
    
    // init labels
    
    let itemNameLabel = UILabel()
    let itemPurchasedDateLabel = UILabel()
    let itemCostPerWeekLabel = UILabel()
    
    
    func initItemNameLabel() {
        self.addSubview(itemNameLabel)
        
        itemNameLabel.text = "\(item.name)"
        //        itemNameLabel.sizeToFit()
        itemNameLabel.font = .systemFont(ofSize: 20, weight: .medium)
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraintsForItemNameLabel: [NSLayoutConstraint] = [
            itemNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            itemNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
            
        ]
        NSLayoutConstraint.activate(constraintsForItemNameLabel)
    }
    
    func initPurchasedDateLabel() {
        self.addSubview(itemPurchasedDateLabel)
        
        itemPurchasedDateLabel.text = "\(item.dateAsString)"
        //        itemPurchasedDateLabel.sizeToFit()
        itemPurchasedDateLabel.font = .systemFont(ofSize: 20, weight: .regular)
        itemPurchasedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraintsForPurchasedDateLabel: [NSLayoutConstraint] = [
            itemPurchasedDateLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 20),
            itemPurchasedDateLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20)
            
        ]
        NSLayoutConstraint.activate(constraintsForPurchasedDateLabel)
    }
    
    func initCostPerWeekLabel() {
        self.addSubview(itemCostPerWeekLabel)
        itemCostPerWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        
        itemCostPerWeekLabel.text = String(item.price)
        itemCostPerWeekLabel.font = .systemFont(ofSize: 20, weight: .regular)
        //        itemCostPerWeekLabel.sizeToFit()
        
        let constraintsForCostPerWeekLabel: [NSLayoutConstraint] = [
            itemCostPerWeekLabel.topAnchor.constraint(equalTo: itemPurchasedDateLabel.bottomAnchor, constant: 20),
            itemCostPerWeekLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            //            itemCostPerWeekLabel.bottomAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            
//            let heightForThisCell: CGFloat = 20 + itemNameLabel.heightAnchor + 20 + itemPurchasedDateLabel.heightAnchor + 20 + itemCostPerWeekLabel.heightAnchor + 20
            
            contentView.heightAnchor.constraint(equalToConstant: 250)
        ]
        NSLayoutConstraint.activate(constraintsForCostPerWeekLabel)
        
        
        
        
    }
    
    //    func initLabel (label: UILabel, text: String, font: UIFont, constraints: [NSLayoutConstraint]) {
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //        self.addSubview(label)
    //        label.text = text
    //        label.font = font
    //        NSLayoutConstraint.activate(constraints)
    //
    //    }
    
    
    
}
