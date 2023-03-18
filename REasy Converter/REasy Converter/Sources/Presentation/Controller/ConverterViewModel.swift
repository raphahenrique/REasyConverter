//
//  ConverterViewModel.swift
//  REasy Converter
//
//  Created by Raphael on 13/03/23.
//

import Foundation

protocol ConverterViewModelProtocol {
    var hint: String { get }
    var rate: Double { get set }
    var firstSelectedCurrency: Currency? { get set }
    var secondSelectedCurrency: Currency? { get set }
    mutating func setFirstToSecondValues(value: Double)
    mutating func setSecondToFirstValues(value: Double)
}

struct ConverterViewModel: ConverterViewModelProtocol {
    
    var hint: String
    var rate: Double
    var firstSelectedCurrency: Currency?
    var secondSelectedCurrency: Currency?
    
    init(rate: Double = 0.00636) {
        self.hint = "* taxa utilizada: (CLP)1000.0 -> (BRL)6.36"
        self.firstSelectedCurrency = Currency(locale: "es_CL", amount: 1000.0)
        self.secondSelectedCurrency = Currency(locale: "pt_BR", amount: 1000 * rate)
        self.rate = rate
    }
    
    mutating func setFirstToSecondValues(value: Double) {
        firstSelectedCurrency?.amount = value
        secondSelectedCurrency?.amount = value * rate
    }

    mutating func setSecondToFirstValues(value: Double) {
        secondSelectedCurrency?.amount = value
        firstSelectedCurrency?.amount = value * (1/rate)
    }

    private func calculate(a: Double, b: Double) -> Double {
        return 0.0
    }
}
