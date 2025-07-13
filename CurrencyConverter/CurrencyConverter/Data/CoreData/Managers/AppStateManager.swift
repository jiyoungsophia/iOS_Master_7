//
//  AppStateManager.swift
//  CurrencyConverter
//
//  Created by Milou on 7/13/25.
//

import Foundation
import CoreData

protocol AppStateManagerProtocol {
    func saveAppState(screen: ScreenType, currency: String?) // Create
    func loadAppState() -> (screen: ScreenType, currency: String?)? // Read
}

final class AppStateManager: AppStateManagerProtocol {
    
    static let shared = AppStateManager()
    private init() {}
    
    private var context: NSManagedObjectContext {
        return CoreDataManager.shared.context
    }
    
    // MARK: - CRD
    
    /// Create
    func saveAppState(screen: ScreenType, currency: String? = nil) {
        deleteAllAppStates()
        
        _ = AppState(
            lastScreen: screen.rawValue,
            lastCurrency: currency,
            context: context
        )
        
        CoreDataManager.shared.saveContext()
    }
    
    /// Read
    func loadAppState() -> (screen: ScreenType, currency: String?)? {
        let request = AppState.fetchRequest()
        
        do {
            let states = try context.fetch(request)
            
            guard let state = states.first,
                  let screenState = state.lastScreen,
                  let screen = ScreenType(rawValue: screenState) else {
                return nil
            }
            
            return (screen: screen, currency: state.lastCurrency)
        } catch {
            print("❌ 앱 상태 로드 실패: \(error)")
            return nil
        }
    }
    
    // MARK: - Private
    
    private func deleteAllAppStates() {
        let request = AppState.fetchRequest()
        
        do {
            let states = try context.fetch(request)
            for state in states {
                context.delete(state)
            }
        } catch {
            print("❌ 앱 상태 삭제 실패: \(error)")
        }
    }
}
