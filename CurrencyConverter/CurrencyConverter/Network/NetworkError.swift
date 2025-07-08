//
//  NetworkError.swift
//  CurrencyConverter
//
//  Created by Milou on 7/8/25.
//

import Foundation

enum NetworkError: Error {
    case httpResponseError   // HTTP Response 변환 실패
    case decodingError   // JSON 디코딩 실패
    case serverError(statusCode: Int)   // 서버 오류 (400, 500)
    case urlError(URLError)   // 네트워크 연결 문제
    case error(Error)   // 기타 에러

    var localizedDescription: String {
        switch self {
        case .httpResponseError:
            return "⛑️ HTTP Response 값 없음"
        case .decodingError:
            return "⛑️ 디코딩 오류"
        case .serverError(let statusCode):
            return "⛑️ 서버 오류 \(statusCode)"
        case .urlError(let urlError):
            return urlError.localizedDescription
        case .error(let error):
            return error.localizedDescription
        }
    }
}
