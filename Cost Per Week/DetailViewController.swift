//
//  DetailViewController.swift
//  Cost Per Week
//
//  Created by Wheatley on 31.10.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var delegate: retrieveItemDegelate?
    
    var importedItem: Item?
    
    
    // initialising UIKit items
    
    let nameTextField = UITextField()
    let priceTextField = UITextField()
    let datePicker = UIDatePicker()
    let saveButton = UIButton(configuration: .bordered(), primaryAction: nil)
    
    
    @objc func saveAndExit() {
        
        let nameOfRetrievedItem = String(nameTextField.text ?? "no value")
        let priceOfRetrievedItem = Int(priceTextField.text!) ?? 0
        
        let item = Item(name: nameOfRetrievedItem, price: priceOfRetrievedItem, date: datePicker.date)
        
        guard importedItem != nil else {
            
            delegate?.addItemToList(item: item)
            dismiss(animated: true)
            return
        }
        
        delegate?.editItem(item: item)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        priceTextField.delegate = self
//        saveButton.isUserInteractionEnabled = false
        self.view.backgroundColor = .systemGray6
        saveButton.tintColor = .systemPink
        
        self.saveButton.addTarget(self, action: #selector(saveAndExit), for: .touchUpInside)
        
        if importedItem == nil {
            saveButton.isUserInteractionEnabled = false
            saveButton.alpha = 0.5
        }
        
        // making anchors work
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        // adding subbiews
        
        view.addSubview(nameTextField)
        view.addSubview(priceTextField)
        view.addSubview(saveButton)
        view.addSubview(datePicker)
        
        
        // saveButton config
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.configuration = .borderedProminent()
        
        
        // nameTextField config
        
        let nameOfCurrentItem: String = importedItem?.name ?? ""
        
        nameTextField.placeholder = "name"
        nameTextField.text = nameOfCurrentItem
        nameTextField.borderStyle = .roundedRect
        nameTextField.autocapitalizationType = .words
        nameTextField.autocorrectionType = .no
        
        // priceTextField config
        
        priceTextField.borderStyle = .roundedRect
        priceTextField.autocapitalizationType = .none
        priceTextField.autocorrectionType = .no
        priceTextField.keyboardType = .numberPad
        priceTextField.returnKeyType = .done
        
        let priceOfCurrentItem: String = {
            guard let price = importedItem?.price else {return ""}
            return String(price)
        }()
        
        
        priceTextField.placeholder = "price"
        priceTextField.text = priceOfCurrentItem
        
        
        // datePicker config
        
        datePicker.datePickerMode = .date
        datePicker.date = importedItem?.date ?? Date()
        
        // constraints
        
        let detailViewConstraints: [NSLayoutConstraint] = [
            
            
            // nameTextField constraints
            
            nameTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            
            
            // priceTextField constraints
            
            priceTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            priceTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            priceTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            
            
            // datePicker constraints
            
            //            datePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            //            datePicker.widthAnchor.constraint(equalTo: priceTextField.widthAnchor),
            datePicker.heightAnchor.constraint(equalTo: priceTextField.heightAnchor),
            datePicker.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 30),
            datePicker.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            
            // saveButton constraints
            
            saveButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 30),
            saveButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            saveButton.widthAnchor.constraint(equalTo: priceTextField.widthAnchor)
            
            
        ]
        
        NSLayoutConstraint.activate(detailViewConstraints)
        nameTextField.becomeFirstResponder()
        
    }
}


extension DetailViewController: UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        // making backspace work
        
        guard !string.isEmpty else {
            return true
        }
        
        
        // checking if textfields are empty
        
//        let combinedTextFromStrings = "\(nameTextField.text!)" + "\(priceTextField.text!)"
        
        let textFromBothStrings = "\(nameTextField.text!)\(priceTextField.text!)"
        
        let bothStringsAreNotEmpty: Bool = !nameTextField.text!.isEmpty && !priceTextField.text!.isEmpty
        
        print(textFromBothStrings)
        print(bothStringsAreNotEmpty)
        

        if bothStringsAreNotEmpty {
            saveButton.isUserInteractionEnabled = true
            saveButton.alpha = 1.0
        } else {
            saveButton.isUserInteractionEnabled = false
            saveButton.alpha = 0.5
        }
        
        if nameTextField.keyboardType == .default {
            return true
        }
        
        
        // making priceTextField numbers only
        
        if priceTextField.keyboardType == .numberPad {
            if CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) {
                
                
                return false
            }
        }
        
        return true
    }
}




protocol retrieveItemDegelate {
    func addItemToList (item: Item)
    func editItem(item: Item)
}
