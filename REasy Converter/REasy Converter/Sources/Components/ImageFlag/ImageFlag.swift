//
//  ImageFlag.swift
//  PocketChange ConvMoeda
//
//  Created by Raphael on 18/11/23.
//

import Foundation

enum ImageFlagHelper {
    
    static let baseURL = "https://flagsapi.com/"
    
    static func flagURL(forCountry country: Country, size: Int = 32) -> String {
        return "\(baseURL)\(country.code)/flat/\(size).png"
    }

}

enum Country: String {
    case brazil = "BR"
    case chile = "CL"
    case unitedStates = "US"
    case europeanUnion = "EU"

    var code: String {
        return rawValue
    }

    var locale: String {
        switch self {
        case .brazil:
            return "pt_BR"
        case .chile:
            return "es_CL"
        default:
            return "en_US"
        }
    }
    
    var currencyCode: String {
        switch self {
        case .brazil:
            return "BRL"
        case .chile:
            return "CLP"
        case .unitedStates:
            return "USD"
        case .europeanUnion:
            return "EUR"
        }
    }

    static func defaultRate(from: Country, to: Country) -> Float {
        switch (from, to) {
        case (.brazil, .unitedStates):
            return 0.2
        case (.brazil, .chile):
            return 180.0
        case (.brazil, .europeanUnion):
            return 0.19
        case (.chile, .unitedStates):
            return 0.001134
        default:
            return 20.0
        }
    }

}
