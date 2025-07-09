//
//  ExchangeRateService.swift
//  CurrencyConverter
//
//  Created by Milou on 7/8/25.
//

import Foundation

class ExchangeRateService {
    private let networkClient = NetworkClient.shared
    private let baseURL = "https://api.exchangerate-api.com/v4/latest"
    
    func fetchExchangeRate(
        baseCurrency: String = "KRW",
        completion: @escaping (Result<[ExchangeRate], NetworkError>) -> Void
    ) {
        guard let url = URL(string: "\(baseURL)/\(baseCurrency)") else {
            completion(.failure(.httpResponseError))
            return
        }
        
        networkClient.fetchData(url: url) { (result: Result<ExchangeRateResponse, NetworkError>) in
            switch result {
            case .success(let response):
                let exchangeRates = response.toExchangeRates()
                completion(.success(exchangeRates))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
