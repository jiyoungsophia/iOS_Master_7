//
//  BookResponseDTO.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/16/25.
//

import Foundation

// JSON 구조를 매핑하고 Domain Entity로 변환
struct BookResponseDTO: Decodable {
    let data: [BookDTO]
}

extension BookResponseDTO {
    struct BookDTO: Decodable {
        let attributes: BookAttributesDTO
    }
}

extension BookResponseDTO.BookDTO {
    struct BookAttributesDTO: Decodable {
        private enum CodingKeys: String, CodingKey {
            case title
            case author
            case pages
            case releaseDate = "release_date"
            case dedication
            case summary
            case wikiURL = "wiki"
            case chapters
        }
        
        let title: String
        let author: String
        let pages: Int
        let releaseDate: String
        let dedication: String
        let summary: String
        let wikiURL: String
        let chapters: [ChapterDTO]
    }
}

extension BookResponseDTO.BookDTO.BookAttributesDTO {
    struct ChapterDTO: Decodable {
        let title: String
    }
}

// MARK: - Mapping DTO to Domain
extension BookResponseDTO {
    func toDomain() -> [Book] {
        return data.map { $0.toDomain() }
    }
}

extension BookResponseDTO.BookDTO {
    func toDomain() -> Book {
        return attributes.toDomain()
    }
}

extension BookResponseDTO.BookDTO.BookAttributesDTO {
    func toDomain() -> Book {
        return Book(
            title: title,
            author: author,
            releaseDate: DateFormatter.enDateFormatter.date(from: releaseDate) ?? Date(),
            pages: pages,
            wikiURL: URL(string: wikiURL) ?? URL(string: "https://harrypotter.fandom.com")!,
            dedication: dedication,
            summary: summary,
            chapters: chapters.map { $0.title }
        )
    }
}
