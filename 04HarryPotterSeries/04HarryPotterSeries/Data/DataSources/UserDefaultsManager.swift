//
//  UserDefaultsManager.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/20/25.
//

import Foundation


final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let userDefaults = UserDefaults.standard
    
    func saveSummaryState(_ isExpanded: Bool, of bookTitle: String) {
        let key = "summary_state_\(bookTitle)"
        userDefaults.set(isExpanded, forKey: key)
    }
    
    func loadSummaryState(of bookTitle: String) -> Bool {
        let key = "summary_state_\(bookTitle)"
        return userDefaults.bool(forKey: key)
    }
}
