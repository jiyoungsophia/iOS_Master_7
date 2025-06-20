//
//  BookViewModel.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/17/25.
//

import Foundation

final class BookViewModel {
    
    // MARK: - Properties
    private let bookRepository: BookRepository
    private var books: [Book] = []
    private(set) var selectedBookIndex: Int = 0
    
    // MARK: - Computed Properties
    private var currentBook: Book? {
        guard selectedBookIndex < books.count else {
            return nil
        }
        return books[selectedBookIndex]
    }
    
    var bookTitle: String {
        return currentBook?.title ?? "title not available"
    }
    
    var seriesNumber: String {
        return "\(selectedBookIndex + 1)"
    }
    
    var author: String {
        return currentBook?.author ?? "author not available"
    }
    
    var releaseDate: String {
        return DateFormatter.enDateFormatter.string(from: currentBook?.releaseDate ?? Date())
    }
    
    var pages: String {
        return "\(currentBook?.pages ?? 0)"
    }
    
    var bookImageName: String {
        return "harrypotter\(selectedBookIndex + 1)"
    }
    
    var dedication: String {
        return currentBook?.dedication ?? "dedication not available"
    }
    
    var summary: String {
        return currentBook?.summary ?? "summary not available"
    }
    
    var chapters: [String] {
        return currentBook?.chapters ?? []
    }
    
    var totalBooksCount: Int {
        return books.count
    }
    
    // MARK: - Closures
    var onDataLoaded: (() -> Void)?
    var onError: ((DataServiceError) -> Void)?
    
    // MARK: - Initializers
    init(bookRepository: BookRepository) {
        self.bookRepository = bookRepository
    }
    
    // MARK: - Public Methods
    func loadBooks() {
        let result = bookRepository.loadBooks()
        
        switch result {
        case .success(let books):
            self.books = books
            self.onDataLoaded?()
            
        case .failure(let error):
            self.onError?(error)
        }
    }
    
    func selectBook(at index: Int) {
        selectedBookIndex = index
        
        DispatchQueue.main.async { [weak self] in
            self?.onDataLoaded?()
        }
    }
    
    // MARK: - UserDefaults Methods
    func loadSummaryExpandedState() -> Bool {
        return UserDefaultsManager.shared.loadSummaryState(of: bookTitle)
    }
    
    func saveSummaryExpandedState(_ isExpanded: Bool) {
        UserDefaultsManager.shared.saveSummaryState(isExpanded, of: bookTitle)
    }
}
