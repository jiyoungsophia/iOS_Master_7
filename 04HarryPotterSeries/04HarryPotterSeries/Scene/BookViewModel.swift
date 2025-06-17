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
    
    var bookTitle: String {
        guard selectedBookIndex < books.count else {
            return "제목 불러올 수 없음"
        }
        return books[selectedBookIndex].title
    }
    
    var seriesNumber: String {
        return "\(selectedBookIndex + 1)"
    }
    
    func loadBooks() {
        let result = bookRepository.loadBooks()
        
        switch result {
        case .success(let books):
            self.books = books
        case .failure(let error):
            print("Error: \(error)") 
        }
    }
    
    init(bookRepository: BookRepository) {
        self.bookRepository = bookRepository
    }
}
