//
//  BookRepository.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/17/25.
//

protocol BookRepository {
    func loadBooks() -> Result<[Book], DataServiceError>
}
