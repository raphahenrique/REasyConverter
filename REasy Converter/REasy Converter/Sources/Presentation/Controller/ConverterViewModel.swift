//
//  ConverterViewModel.swift
//  REasy Converter
//
//  Created by Raphael on 13/03/23.
//

import Foundation

protocol ConverterViewModelProtocol {
    var rate: Double { get set }
    var firstSelectedCurrency: Currency? { get set }
    var secondSelectedCurrency: Currency? { get set }
    mutating func setFirstToSecondValues(value: Double)
    mutating func setSecondToFirstValues(value: Double)
}

struct ConverterViewModel: ConverterViewModelProtocol {
    
    var rate: Double
    var firstSelectedCurrency: Currency?
    var secondSelectedCurrency: Currency?
    
    init(rate: Double = 2.5) {
        self.firstSelectedCurrency = Currency(locale: "es_CL", amount: 100.0)
        self.secondSelectedCurrency = Currency(locale: "pt_BR", amount: 100.0)
        self.rate = rate
    }
    
    mutating func setFirstToSecondValues(value: Double) {
        firstSelectedCurrency?.amount = value
        secondSelectedCurrency?.amount = value * rate
    }

    mutating func setSecondToFirstValues(value: Double) {
        secondSelectedCurrency?.amount = value
        firstSelectedCurrency?.amount = value / rate
    }

}
