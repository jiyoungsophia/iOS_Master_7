//
//  ExchangeRateRecord+CoreDataClass.swift
//  CurrencyConverter
//
//  Created by Milou on 7/13/25.
//
//

import Foundation
import CoreData

@objc(ExchangeRateRecord)
public class ExchangeRateRecord: NSManagedObject {
    
    convenience init(
            currencyCode: String,
            rate: Double,
            trend: TrendDirection,
            lastUpdateTime: Int64,
            context: NSManagedObjectContext
        ) {
            self.init(context: context)
            self.currencyCode = currencyCode
            self.rate = rate
            self.trend = trend.rawValue
            self.lastUpdateTime = lastUpdateTime
        }
}
