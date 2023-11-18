//
//  ConverterViewModel.swift
//  REasy Converter
//
//  Created by Raphael on 13/03/23.
//

import Foundation

protocol ConverterViewModelProtocol {
    var exchangeRate: ExchangeRate { get }
    var hint: String { get }
    var firstSelectedCurrency: CurrencyTF? { get set }
    var secondSelectedCurrency: CurrencyTF? { get set }
    mutating func setFirstToSecondValues(value: Double)
    mutating func setSecondToFirstValues(value: Double)
}

struct ConverterViewModel: ConverterViewModelProtocol {
    
    var exchangeRate: ExchangeRate
    var hint: String
    var firstSelectedCurrency: CurrencyTF?
    var secondSelectedCurrency: CurrencyTF?
    
    init(exchangeRate: ExchangeRate) {
        self.exchangeRate = exchangeRate
        let initialTopAmount = Float(1000.0)
        let initialSecondAmount = initialTopAmount * exchangeRate.rate
        
        let secondAmount1st = Float(1.0)
        let firstAmount2nd = String(format: "%.2f", secondAmount1st / exchangeRate.rate)

        let fromCountry = Country(rawValue: exchangeRate.fromCurrency?.name ?? String()) ?? .brazil
        let toCountry = Country(rawValue: exchangeRate.toCurrency?.name ?? String()) ?? .brazil
        
        self.firstSelectedCurrency = CurrencyTF(
            locale: fromCountry.locale,
            amount: Double(initialTopAmount)
        )
        self.secondSelectedCurrency = CurrencyTF(
            locale: toCountry.locale,
            amount: Double(initialSecondAmount)
        )
        self.hint = "taxa utilizada: (\(fromCountry.currencyCode))\(initialTopAmount) -> (\(toCountry.currencyCode))\(initialSecondAmount)\nou: (\(toCountry.currencyCode))\(secondAmount1st) -> (\(fromCountry.currencyCode))\(firstAmount2nd)"

    }
    
    mutating func setFirstToSecondValues(value: Double) {
        firstSelectedCurrency?.amount = value
        secondSelectedCurrency?.amount = value * Double(exchangeRate.rate)
    }

    mutating func setSecondToFirstValues(value: Double) {
        secondSelectedCurrency?.amount = value
        firstSelectedCurrency?.amount = value * (1/Double(exchangeRate.rate))
    }

}
