//
//  Currency+CoreDataProperties.swift
//  PocketChange ConvMoeda
//
//  Created by Raphael on 18/11/23.
//
//

import Foundation
import CoreData


extension Currency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Currency> {
        return NSFetchRequest<Currency>(entityName: "Currency")
    }

    @NSManaged public var flagURL: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?

}

extension Currency : Identifiable {

}
