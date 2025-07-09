//
//  ExchangeRate.swift
//  CurrencyConverter
//
//  Created by Milou on 7/8/25.
//

import Foundation

struct ExchangeRate: Codable {
    let currency: String
    let country: String
    let rate: Double
}
