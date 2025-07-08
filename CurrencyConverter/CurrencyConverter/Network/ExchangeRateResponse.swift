//
//  ExchangeRateResponse.swift
//  CurrencyConverter
//
//  Created by Milou on 7/8/25.
//

import Foundation

struct ExchangeRateResponse: Codable {
    let rates: [String: Double]
    
    func toExchangeRates() -> [ExchangeRate] {
        return rates.map { (currency, rate) in
            ExchangeRate(currency: currency, rate: rate)
        }
    }
}
