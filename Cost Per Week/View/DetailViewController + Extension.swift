//
//  DetailViewController + Extension.swift
//  Cost Per Week
//
//  Created by Wheatley on 23.10.2022.
//

import UIKit

extension DetailViewController: UITextFieldDelegate {
    
    
    // save button is only enabled when nameTextField and priceTextField are both not empty
    
    func checkIfButtonIsEnabled() {
        if nameTextField.text?.isEmpty == true || priceTextField.text?.isEmpty == true {
            saveButton.isEnabled = false
        } else if nameTextField.text?.isEmpty == false && priceTextField.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else { return }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkIfButtonIsEnabled()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        checkIfButtonIsEnabled()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        checkIfButtonIsEnabled()
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // priceTextField can only have numbers as input
        
        if textField == priceTextField {
            let allowedCharacters = CharacterSet.decimalDigits
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        // making backspace work
        
        guard !string.isEmpty else {
            return true
        }
        
        return true
    }
    
    
    func addAbilityToDelete() {
        let deleteTabButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteItem))
        navigationItem.rightBarButtonItem = deleteTabButton
    }
    
    @objc func deleteItem() {
        guard let item = importedItem else {return}
        delegate?.deleteItem(item: item)
        navigationController?.popViewController(animated: true)
    }
}
