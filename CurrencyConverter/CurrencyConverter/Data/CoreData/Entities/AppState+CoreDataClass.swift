//
//  AppState+CoreDataClass.swift
//  CurrencyConverter
//
//  Created by Milou on 7/13/25.
//
//

import Foundation
import CoreData

@objc(AppState)
public class AppState: NSManagedObject {
    
    convenience init(
           lastScreen: String,
           lastCurrency: String?,
           context: NSManagedObjectContext
       ) {
           self.init(context: context)
           self.lastScreen = lastScreen
           self.lastCurrency = lastCurrency
       }
}
