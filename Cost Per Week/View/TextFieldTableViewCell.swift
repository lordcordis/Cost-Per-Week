//
//  TextFieldTableViewCell.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 14.04.2023.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    var textField = UITextField()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure() {
        
        contentView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive = true
        textField.placeholder = "sample"
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
