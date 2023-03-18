//
//  Currency.swift
//  REasy Converter
//
//  Created by Raphael on 15/03/23.
//

import Foundation

struct Currency {

    var locale: String
    
    var amount: Double
    
    var code: String? {
        return formatter.currencyCode ?? "N/A"
    }
    
    var symbol: String? {
        return formatter.currencySymbol  ?? "N/A"
    }
    
    var format: String {
        return formatter.string(from: NSNumber(value: self.amount))!
    }

    var formatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: self.locale)
        numberFormatter.numberStyle = .currency
        
        return numberFormatter
    }
    
}
