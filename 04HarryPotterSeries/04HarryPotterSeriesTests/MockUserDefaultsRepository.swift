//
//  MockUserDefaultsRepository.swift
//  04HarryPotterSeriesTests
//
//  Created by Milou on 6/23/25.
//

import XCTest
@testable import HarryPotterSeriesApp

final class MockUserDefaultsRepository: UserDefaultsRepository {
    var savedStates: [String: Bool] = [:]

    func saveSummaryState(_ isExpanded: Bool, of bookTitle: String) {
        savedStates[bookTitle] = isExpanded
    }

    func loadSummaryState(of bookTitle: String) -> Bool {
        return savedStates[bookTitle] ?? false
    }
}
