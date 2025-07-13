//
//  ExchangeRateResponse.swift
//  CurrencyConverter
//
//  Created by Milou on 7/8/25.
//

import Foundation

struct ExchangeRateResponse: Codable {
    let rates: [String: Double]
    let timeLastUpdateUnix: Int64
    
    enum CodingKeys: String, CodingKey {
        case rates
        case timeLastUpdateUnix = "time_last_update_unix"
    }
    
    var lastUpdateDate: Date {
        return Date(timeIntervalSince1970: TimeInterval(timeLastUpdateUnix))
    }
    
    func toExchangeRates() -> [ExchangeRate] {
        return rates.map { (currency, rate) in
            ExchangeRate(
                currency: currency,
                country: CurrencyMapping.getCountryName(from: currency),
                rate: rate
            )
        }.sorted { $0.currency < $1.currency }
    }
}
