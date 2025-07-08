//
//  ExchangeRate.swift
//  CurrencyConverter
//
//  Created by Milou on 7/8/25.
//

import Foundation

struct ExchangeRate: Codable {
    let currencyCode: String
    let rate: Double
}
