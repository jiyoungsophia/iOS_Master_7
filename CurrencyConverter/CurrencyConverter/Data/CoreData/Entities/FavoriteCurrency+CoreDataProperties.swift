//
//  FavoriteCurrency+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by Milou on 7/11/25.
//
//

import Foundation
import CoreData


extension FavoriteCurrency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCurrency> {
        return NSFetchRequest<FavoriteCurrency>(entityName: "FavoriteCurrency")
    }

    @NSManaged public var currencyCode: String?

}

extension FavoriteCurrency : Identifiable {

}
