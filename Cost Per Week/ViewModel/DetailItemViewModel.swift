//
//  DetailItemViewModel.swift
//  Cost Per Week
//
//  Created by Роман Коренев on 07.04.2023.
//

import Foundation

protocol DetailItemViewModelProtocol {
    
}


struct DetailItemViewModel: DetailItemViewModelProtocol {
    

    
    
    private var nameString: String
    private var dateString: String
    private var costPerWeekString: String
    private var percentageOfProgressBarFloat: Float
    
    func name() -> String {
        return ""
    }
    
}
