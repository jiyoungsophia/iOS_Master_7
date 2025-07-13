//
//  CoreDataManager.swift
//  CurrencyConverter
//
//  Created by Milou on 7/13/25.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    // MARK: - Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CurrencyConverter")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("❌ CoreData 로드 실패: \(error)")
            } 
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Save Context
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("❌ CoreData 저장 실패: \(error)")
            }
        }
    }
}
