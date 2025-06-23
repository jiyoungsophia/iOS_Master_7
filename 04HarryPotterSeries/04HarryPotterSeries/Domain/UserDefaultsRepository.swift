//
//  UserDefaultsRepository.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/23/25.
//

import Foundation

protocol UserDefaultsRepository {
    func saveSummaryState(_ isExpanded: Bool, of bookTitle: String)
    func loadSummaryState(of bookTitle: String) -> Bool
}
