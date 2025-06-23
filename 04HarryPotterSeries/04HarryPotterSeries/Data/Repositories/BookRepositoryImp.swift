//
//  BookRepository.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/16/25.
//

import Foundation


final class BookRepositoryImp: BookRepository {
    private let jsonDataService: JSONDataService
    
    init(jsonDataService: JSONDataService) {
        self.jsonDataService = jsonDataService
    }
    
    func loadBooks() -> Result<[Book], DataServiceError> {
        do {
            let bookResponseDTO = try jsonDataService.loadBooksData()
            let books = bookResponseDTO.toDomain()
            
            guard !books.isEmpty else {
                return .failure(.emptyData)
            }
            
            return .success(books)
        } catch let dataServiceError as DataServiceError {
            return .failure(dataServiceError)
        } catch {
            return .failure(.loadingFailed(error))
        }
    }
}
