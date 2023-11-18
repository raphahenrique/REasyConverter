//
//  ExchangeRate+CoreDataProperties.swift
//  PocketChange ConvMoeda
//
//  Created by Raphael on 18/11/23.
//
//

import Foundation
import CoreData


extension ExchangeRate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExchangeRate> {
        return NSFetchRequest<ExchangeRate>(entityName: "ExchangeRate")
    }

    @NSManaged public var id: Int32
    @NSManaged public var rate: Float
    @NSManaged public var fromCurrency: Currency?
    @NSManaged public var toCurrency: Currency?

}

extension ExchangeRate : Identifiable {

}
