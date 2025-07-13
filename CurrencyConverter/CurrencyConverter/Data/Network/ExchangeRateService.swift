//
//  ExchangeRateService.swift
//  CurrencyConverter
//
//  Created by Milou on 7/8/25.
//

import Foundation

final class ExchangeRateService {
    private let networkClient = NetworkClient.shared
    private let baseURL = "https://open.er-api.com/v6/latest"
    
    func fetchExchangeRate(
        baseCurrency: String = "KRW",
        completion: @escaping (Result<ExchangeRateResponse, NetworkError>) -> Void
    ) {
        guard let url = URL(string: "\(baseURL)/\(baseCurrency)") else {
            completion(.failure(.httpResponseError))
            return
        }
        
        networkClient.fetchData(url: url) { (result: Result<ExchangeRateResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
