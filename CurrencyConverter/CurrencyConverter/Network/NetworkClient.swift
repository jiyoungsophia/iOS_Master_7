//
//  NetworkClient.swift
//  CurrencyConverter
//
//  Created by Milou on 7/8/25.
//

import Foundation

final class NetworkClient {
    static let shared = NetworkClient()
    private init() {}
    
    private let successRange = 200..<300
    
    func fetchData<T: Decodable>(url: URL) async -> Result<T, NetworkError> {
        do {
            // 1. URLRequest 생성 및 설정
            let request = createRequest("GET", url: url)
            
            // 2. URLSession으로 네트워크 요청 실행
            let (data, response) = try await URLSession.shared.data(for: request)
            
            // 3. HTTPURLResponse로 변환 확인
            guard let statusCode = getStatusCode(from: response) else {
                return .failure(.httpResponseError)
            }
            
            // 4. 상태 코드 검증
            guard successRange.contains(statusCode) else {
                let error = NetworkError.serverError(statusCode: statusCode)
                return .failure(error)
            }
            
            // 5. JSON 디코딩
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return .success(decodedData)
            } catch {
                return .failure(.decodingError)
            }
            
        } catch {
            // 6. URLError 처리
            if let urlError = error as? URLError {
                return .failure(.urlError(urlError))
            } else {
                return .failure(.error(error))
            }
        }
    }
}

extension NetworkClient {
    /// URLRequest 생성
    func createRequest(_ httpMethod: String, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        // HTTP 헤더 설정, addValue: 추가, setValue: 대치
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    /// HTTPURLResponse에서 상태 코드 추출
    func getStatusCode(from response: URLResponse) -> Int? {
        return (response as? HTTPURLResponse)?.statusCode
    }
}
