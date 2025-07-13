//
//  ExchangeRateRecord+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by Milou on 7/13/25.
//
//

import Foundation
import CoreData


extension ExchangeRateRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExchangeRateRecord> {
        return NSFetchRequest<ExchangeRateRecord>(entityName: "ExchangeRateRecord")
    }

    @NSManaged public var currencyCode: String?
    @NSManaged public var rate: Double
    @NSManaged public var trend: String?
    @NSManaged public var lastUpdateTime: Int64

}

extension ExchangeRateRecord : Identifiable {

}
