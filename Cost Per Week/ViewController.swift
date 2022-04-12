//
//  ViewController.swift
//  Cost Per Week
//
//  Created by Wheatley on 27.10.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var itemList = [Item]()
    
    let itemNameLabel = UILabel()
    let itemPurchasedDateLabel = UILabel()
    let itemCostPerWeekLabel = UILabel()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .lightGray
            initItemNameLabel()
            initPurchasedDateLabel()
            initCostPerWeekLabel()
        }
    
    func initItemNameLabel() {
        self.view.addSubview(itemNameLabel)
        
        itemNameLabel.text = "Item Name"
        itemNameLabel.font = .systemFont(ofSize: 20, weight: .medium)
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraintsForItemNameLabel: [NSLayoutConstraint] = [
            itemNameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            itemNameLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
            
        ]
        NSLayoutConstraint.activate(constraintsForItemNameLabel)
    }
    
    func initPurchasedDateLabel() {
        self.view.addSubview(itemPurchasedDateLabel)
        
        itemPurchasedDateLabel.text = "Purchased Date"
        itemPurchasedDateLabel.font = .systemFont(ofSize: 20, weight: .regular)
        itemPurchasedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let constraintsForPurchasedDateLabel: [NSLayoutConstraint] = [
            itemPurchasedDateLabel.topAnchor.constraint(equalTo: itemNameLabel.bottomAnchor, constant: 20),
            itemPurchasedDateLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
            
        ]
        NSLayoutConstraint.activate(constraintsForPurchasedDateLabel)
    }
    
    func initCostPerWeekLabel() {
        self.view.addSubview(itemCostPerWeekLabel)
        
        itemCostPerWeekLabel.text = "Item Cost Per Week"
        itemCostPerWeekLabel.font = .systemFont(ofSize: 20, weight: .regular)
        itemCostPerWeekLabel.sizeToFit()
        
        let constraintsForCostPerWeekLabel: [NSLayoutConstraint] = [
            itemCostPerWeekLabel.topAnchor.constraint(equalTo: itemPurchasedDateLabel.bottomAnchor, constant: 20),
            itemCostPerWeekLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraintsForCostPerWeekLabel)
        
        itemCostPerWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    func initLabel (label: UILabel, text: String, font: UIFont, constraints: [NSLayoutConstraint]) {
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        label.text = text
        label.font = font
        NSLayoutConstraint.activate(constraints)
        
    }
    
        

}

