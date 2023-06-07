//
//  DetailViewController.swift
//  Cost Per Week
//
//  Created by Wheatley on 31.10.2021.
//

import UIKit

final class DetailViewController: UIViewController {
    
    var delegate: ItemDelegate?
    
    var importedItem: Item?
    
    //MARK: initialising UIKit items
    
    let nameTextField = UITextField()
    let priceTextField = UITextField()
    let datePicker = UIDatePicker()
    let saveButton = UIButton(configuration: .bordered(), primaryAction: nil)
    
    //MARK: save data and exit from detailView
    
    @objc func saveAndExit() {
        
        let nameOfRetrievedItem = String(nameTextField.text ?? "no value")
        
        guard let stringFromPriceTextField = priceTextField.text, let priceOfRetrievedItem = Double(stringFromPriceTextField) else {return}
        
        guard var item = importedItem else {

            print("new item")
            
            let newItem = Item(name: nameOfRetrievedItem, price: Int(priceOfRetrievedItem), date: datePicker.date)
            delegate?.addItemToList(item: newItem)
            dismiss(animated: true)
            return
            
        }
        print("imported item")
        item.name = nameOfRetrievedItem
        item.price = Int(priceOfRetrievedItem)
        item.date = datePicker.date
        delegate?.editItem(item: item)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
//        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        super.viewDidLoad()
        nameTextField.delegate = self
        priceTextField.delegate = self
        self.view.backgroundColor = .systemGroupedBackground
        saveButton.tintColor = .systemPink
        saveButton.isEnabled = false
        addAbilityToDelete()
        
        
        self.saveButton.addTarget(self, action: #selector(saveAndExit), for: .touchUpInside)
        
//        if importedItem == nil {
//            saveButton.isEnabled = false
//            saveButton.alpha = 0.5
//        }
        

        
        
        //MARK: adding subbiews
        
        view.addSubview(nameTextField)
        view.addSubview(priceTextField)
        view.addSubview(saveButton)
        view.addSubview(datePicker)
        
        //MARK: making anchors work
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        //MARK: saveButton config
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.configuration = .borderedProminent()
        
        
        //MARK: nameTextField config
        
        let nameOfCurrentItem: String = importedItem?.name ?? ""
        
        nameTextField.placeholder = "Item name"
        nameTextField.text = nameOfCurrentItem
        nameTextField.borderStyle = .roundedRect
        nameTextField.autocapitalizationType = .words
        nameTextField.autocorrectionType = .no
        nameTextField.clearButtonMode = .whileEditing
        
        //MARK: priceTextField config
        
        priceTextField.borderStyle = .roundedRect
        priceTextField.autocapitalizationType = .none
        priceTextField.autocorrectionType = .no
        priceTextField.keyboardType = .decimalPad
        priceTextField.returnKeyType = .done
        priceTextField.clearButtonMode = .whileEditing
        
        let priceOfCurrentItem: String = {
            guard let price = importedItem?.price else {return ""}
            return String(price)
        }()
        
        
        priceTextField.placeholder = "Price"
        priceTextField.text = priceOfCurrentItem
        
        
        //MARK: datePicker config
        
        datePicker.datePickerMode = .date
        datePicker.date = importedItem?.date ?? Date()
        datePicker.maximumDate = Date()
        
        //MARK: constraints for detailView
        
        let detailViewConstraints: [NSLayoutConstraint] = [
            
            
            // nameTextField constraints
            
            nameTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            
            
            // priceTextField constraints
            
            priceTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            priceTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            priceTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            
            
            // datePicker constraints
            
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


//MARK: keyboard control






protocol ItemDelegate {
    func addItemToList (item: Item)
    func editItem(item: Item)
    func deleteItem(item: Item)
}
