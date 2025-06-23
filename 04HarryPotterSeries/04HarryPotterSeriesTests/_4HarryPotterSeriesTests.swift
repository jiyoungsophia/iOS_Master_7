//
//  _4HarryPotterSeriesTests.swift
//  04HarryPotterSeriesTests
//
//  Created by Milou on 6/23/25.
//

import XCTest
@testable import HarryPotterSeriesApp

final class _4HarryPotterSeriesTests: XCTestCase {

    var mockUserDefaults: MockUserDefaultsRepository!
    var mockBookRepository: MockBookRepository!
    var viewModel: BookViewModel!
    
    override func setUp() {
        super.setUp()
        mockUserDefaults = MockUserDefaultsRepository()
        mockBookRepository = MockBookRepository()
        
        viewModel = BookViewModel(
            bookRepository: mockBookRepository,
            userDefaultsRepository: mockUserDefaults
        )
    }
    
    func test_saveSummaryExpandedState_savesCorrectValue() {
        // Given
        mockBookRepository.booksToReturn = [
            Book(title: "HP1", author: "J.K", releaseDate: Date(), pages: 300, wikiURL: URL(string: "www.naver.com")!, dedication: "", summary: "", chapters: [])
        ]
        viewModel.loadBooks()
        viewModel.selectBook(at: 0)
        
        // When
        viewModel.saveSummaryExpandedState(true)
        
        // Then
        XCTAssertEqual(mockUserDefaults.savedStates["HP1"], true)
    }
    
    func test_loadSummaryExpandedState_returnsCorrectValue() {
        // Given
        mockUserDefaults.savedStates["HP1"] = true
        mockBookRepository.booksToReturn = [
            Book(title: "HP1", author: "J.K", releaseDate: Date(), pages: 300, wikiURL: URL(string: "www.naver.com")!, dedication: "", summary: "", chapters: [])
        ]
        viewModel.loadBooks()
        viewModel.selectBook(at: 0)
        
        // When
        let result = viewModel.loadSummaryExpandedState()
        
        // Then
        XCTAssertTrue(result)
    }

}
