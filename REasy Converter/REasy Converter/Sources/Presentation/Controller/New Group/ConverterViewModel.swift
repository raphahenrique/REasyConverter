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
    var isInverted: Bool { get }
}

struct ConverterViewModel: ConverterViewModelProtocol {
    
    var hint: String
    var rate: Double
    var firstSelectedCurrency: Currency?
    var secondSelectedCurrency: Currency?
    var isInverted: Bool
    
    init(rate: Double = 0.00639, isInverted: Bool = false) {
        let newRate = isInverted ? (1/rate) : rate
        if newRate == 0 {
            self.rate = isInverted ? (1/0.00639) : 0.00639
        } else {
            self.rate = newRate
        }
        let initialTopAmount = Double(1000.0)
        let initialSecondAmount = initialTopAmount * self.rate
        
        let secondAmount1st = Double(1.0)
        let firstAmount2nd = String(format: "%.2f", secondAmount1st / self.rate)

        self.firstSelectedCurrency = Currency(locale: "es_CL", amount: initialTopAmount)
        self.secondSelectedCurrency = Currency(locale: "pt_BR", amount: initialSecondAmount)
        self.hint = "taxa utilizada: (CLP)\(initialTopAmount) -> (BRL)\(initialSecondAmount)\nou: (BRL)\(secondAmount1st) -> (CLP)\(firstAmount2nd)"
        self.isInverted = isInverted
    }
    
    mutating func setFirstToSecondValues(value: Double) {
        firstSelectedCurrency?.amount = value
        secondSelectedCurrency?.amount = value * rate
    }

    mutating func setSecondToFirstValues(value: Double) {
        secondSelectedCurrency?.amount = value
        firstSelectedCurrency?.amount = value * (1/rate)
    }

}
