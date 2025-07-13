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
    func removeFavorite(_ currencyCode: String) // Delete
}

final class FavoriteCurrencyManager: FavoriteCurrencyManagerProtocol {
    
    static let shared = FavoriteCurrencyManager()
    private init() {}
    
    private var context: NSManagedObjectContext {
        return CoreDataManager.shared.context
    }
    
    // MARK: - CRD
    
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
        CoreDataManager.shared.saveContext()
    }
}
