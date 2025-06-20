//
//  JSONDataService.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/16/25.
//

import Foundation


// Data -> DTO
protocol JSONDataService {
    func loadBooksData() throws -> BookResponseDTO
}

final class JSONDataServiceImp: JSONDataService {
    private let fileName: String
    
    init(fileName: String = "data") {
        self.fileName = fileName
    }
    
    func loadBooksData() throws -> BookResponseDTO {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw DataServiceError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(BookResponseDTO.self, from: data)
        } catch let decodingError as DecodingError {
            throw DataServiceError.decodingFailed(decodingError)
        } catch {
            throw DataServiceError.loadingFailed(error)
        }
    }
}
