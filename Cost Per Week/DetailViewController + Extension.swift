//
//  DetailViewController + Extension.swift
//  Cost Per Week
//
//  Created by Wheatley on 23.10.2022.
//

import UIKit

extension DetailViewController: UITextFieldDelegate {
    
    
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
        
        
        // making backspace work
        
        guard !string.isEmpty else {
            return true
        }
        
        
        // disable save button if both strings are empty
        
//        let textFromBothStrings = "\(nameTextField.text!)\(priceTextField.text!)"
//
//        let bothStringsAreNotEmpty: Bool = !nameTextField.text!.isEmpty && !priceTextField.text!.isEmpty
//
//        print(textFromBothStrings)
//        print(bothStringsAreNotEmpty)
//
//
//        if bothStringsAreNotEmpty {
//            saveButton.isUserInteractionEnabled = true
//            saveButton.alpha = 1.0
//        } else {
//            saveButton.isUserInteractionEnabled = false
//            saveButton.alpha = 0.5
//        }
//
        if nameTextField.keyboardType == .default {
            return true
        }
        
        

        
        
        // making priceTextField numbers only (needs rework)
        
        if priceTextField.keyboardType == .numberPad {
            if CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) {
                
                
                return false
            }
        }
        
        return true
    }
}
