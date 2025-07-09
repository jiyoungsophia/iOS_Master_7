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
    
    func fetchData<T: Decodable>(
        url: URL,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        // 1. URLRequest 생성 및 설정
        let request = createRequest("GET", url: url)
        
        // 2. URLSession으로 네트워크 요청 실행 (dataTask 사용)
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { data, response, error in
            
            // 3. 네트워크 에러 체크
            if let error = error {
                if let urlError = error as? URLError {
                    completion(.failure(.urlError(urlError)))
                } else {
                    completion(.failure(.error(error)))
                }
                return
            }
            
            // 4. 데이터 확인
            guard let data = data else {
                completion(.failure(.httpResponseError))
                return
            }
            
            // 5. HTTPURLResponse로 변환 확인
            guard let statusCode = self.getStatusCode(from: response) else { 
                completion(.failure(.httpResponseError))
                return
            }
            
            // 6. 상태 코드 검증
            guard self.successRange.contains(statusCode) else {
                let error = NetworkError.serverError(statusCode: statusCode)
                completion(.failure(error))
                return
            }
            
            // 7. JSON 디코딩
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume() // 중요: 네트워크 요청 시작
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
    func getStatusCode(from response: URLResponse?) -> Int? {
        return (response as? HTTPURLResponse)?.statusCode
    }
}
