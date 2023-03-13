//
//  ConverterViewModel.swift
//  REasy Converter
//
//  Created by Raphael on 13/03/23.
//

import Foundation

protocol ConverterViewModelProtocol {
    
    var firstValue: String { get }
    var secondValue: String { get }
    var rate: Double { get }
}

struct ConverterViewModel: ConverterViewModelProtocol {
    
    var firstValue: String
    var secondValue: String
    var rate: Double

    init(firstValue: String,
         secondValue: String, rate: Double = 2.5) {
        self.firstValue = firstValue
        self.secondValue = secondValue
        self.rate = rate
    }
    
}
