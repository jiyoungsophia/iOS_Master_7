//
//  BookViewModel.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/17/25.
//

import Foundation

final class BookViewModel {
    private let bookRepository: BookRepository

    private var books: [Book] = []
    private var selectedBookIndex: Int = 0
    private var currentBook: Book? {
        guard selectedBookIndex < books.count else {
            return nil
        }
        return books[selectedBookIndex]
    }
    
    private(set) var error: DataServiceError?
    
    var onDataLoaded: (() -> Void)?
    var onError: ((DataServiceError) -> Void)?
    
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
    
    func loadBooks() {
        let result = bookRepository.loadBooks()
        
        switch result {
        case .success(let books):
            self.books = books
            DispatchQueue.main.async { [weak self] in
                self?.onDataLoaded?()
            }
        case .failure(let error):
            self.error = error
            DispatchQueue.main.async { [weak self] in
                self?.onError?(error)
            }
        }
    }
    
    func loadSummaryExpandedState() -> Bool {
        return UserDefaultsManager.shared.loadSummaryState(of: bookTitle)
    }
    
    func saveSummaryExpandedState(_ isExpanded: Bool) {
        UserDefaultsManager.shared.saveSummaryState(isExpanded, of: bookTitle)
    }
    
    init(bookRepository: BookRepository) {
        self.bookRepository = bookRepository
    }
    
}
