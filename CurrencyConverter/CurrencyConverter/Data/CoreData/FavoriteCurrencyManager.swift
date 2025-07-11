//
//  FavoriteCurrencyManager.swift
//  CurrencyConverter
//
//  Created by Milou on 7/11/25.
//

import Foundation
import CoreData

protocol FavoriteCurrencyManagerProtocol: AnyObject {
    func addFavorite(_ currencyCode: String) // Create
    func loadFavoriteCurrencies() -> Set<String> // Read
    func removeFavorite(_ currencyCode: String)
}

class FavoriteCurrencyManager: FavoriteCurrencyManagerProtocol {
    
    // MARK: - Core Data Stack
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CurrencyConverter")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                print("CoreData 로드 실패: \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static let shared = FavoriteCurrencyManager()
    private init() {}
    
    
    // MARK: - CRUD
    /// Create
    func addFavorite(_ currencyCode: String) {
        // 이미 존재하는지 확인
        if FavoriteCurrency.exists(currencyCode: currencyCode, context: context) {
            return
        }
        
        // 새로 추가
        let _ = FavoriteCurrency(currencyCode: currencyCode, context: context)
        saveContext()
    }
    
    /// Read
    func loadFavoriteCurrencies() -> Set<String> {
        let currencyCodes = FavoriteCurrency.fetchAllCurrencyCodes(context: context)
        print("📱 CoreData에서 로드된 즐겨찾기: \(currencyCodes)")

        return Set(currencyCodes)
    }
    
    /// Delete
    func removeFavorite(_ currencyCode: String) {
        let request = FavoriteCurrency.fetchRequest(for: currencyCode)
        
        do {
            let favorites = try context.fetch(request)
            for favorite in favorites {
                context.delete(favorite)
            }
            saveContext()
        } catch {
            print("❌ 즐겨찾기 제거 실패: \(error)")
        }
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("💾 CoreData 저장 성공")
            } catch {
                print("❌ CoreData 저장 실패: \(error)")
            }
        }
    }
}
