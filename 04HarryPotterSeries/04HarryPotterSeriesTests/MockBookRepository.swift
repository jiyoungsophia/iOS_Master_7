//
//  MockBookRepository.swift
//  04HarryPotterSeriesTests
//
//  Created by Milou on 6/23/25.
//

import XCTest
@testable import HarryPotterSeriesApp

final class MockBookRepository: BookRepository {
    var booksToReturn: [Book] = []
    
    func loadBooks() -> Result<[Book], DataServiceError> {
        return .success(booksToReturn)
    }
}
