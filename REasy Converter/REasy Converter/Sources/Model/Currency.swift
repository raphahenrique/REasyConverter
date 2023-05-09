//
//  Currency.swift
//  PocketChange ConvMoeda
//
//  Created by Raphael on 24/04/23.
//

import Foundation

struct Currency: Decodable {
    let id: Int
    let name: String
    let shortName: String
    let flagURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case shortName = "short_name"
        case flagURL
    }
}

struct AmountOfCurrencies: Decodable {
    let amount: Int

    enum CodingKeys: String, CodingKey {
        case amount
    }
}
