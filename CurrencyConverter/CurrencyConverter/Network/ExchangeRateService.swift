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
    
    func fetchExchangeRate(baseCurrency: String  = "KRW") async -> Result<[ExchangeRate], NetworkError> {
        guard let url = URL(string: "\(baseURL)/\(baseCurrency)") else {
            return .failure(.httpResponseError)
        }
        
        let result: Result<ExchangeRateResponse, NetworkError> = await networkClient.fetchData(url: url)
        
        switch result {
        case .success(let response):
            let exchangeRates = response.toExchangeRates()
            return .success(exchangeRates)
            
        case .failure(let error):
            return .failure(error)
        }
    }
}
