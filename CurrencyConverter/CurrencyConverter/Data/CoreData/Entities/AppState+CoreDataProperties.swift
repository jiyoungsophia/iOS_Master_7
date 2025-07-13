//
//  AppState+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by Milou on 7/13/25.
//
//

import Foundation
import CoreData


extension AppState {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppState> {
        return NSFetchRequest<AppState>(entityName: "AppState")
    }

    @NSManaged public var lastScreen: String?
    @NSManaged public var lastCurrency: String?

}

extension AppState : Identifiable {

}
