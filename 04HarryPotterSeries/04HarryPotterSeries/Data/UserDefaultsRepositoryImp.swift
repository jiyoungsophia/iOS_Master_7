//
//  UserDefaultsRepositoryImp.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/23/25.
//

import Foundation

final class UserDefaultsRepositoryImp: UserDefaultsRepository {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func saveSummaryState(_ isExpanded: Bool, of bookTitle: String) {
        let key = "summary_state_\(bookTitle)"
        userDefaults.set(isExpanded, forKey: key)
    }
    
    func loadSummaryState(of bookTitle: String) -> Bool {
        let key = "summary_state_\(bookTitle)"
        return userDefaults.bool(forKey: key)
    }
}
