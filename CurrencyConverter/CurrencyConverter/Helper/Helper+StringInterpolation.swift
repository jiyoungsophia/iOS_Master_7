//
//  Helper+StringInterpolation.swift
//  CurrencyConverter
//
//  Created by Milou on 7/10/25.
//

import Foundation

extension String.StringInterpolation {
    
    /// KRW 포맷 (천 단위 콤마, 소수점 없음)
    mutating func appendInterpolation(krw value: Double) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let formatted = formatter.string(from: NSNumber(value: value)) ?? "0"
        appendLiteral(formatted)
    }
    
    /// 계산 통화 포맷 (소수점 2자리)
    mutating func appendInterpolation(currency value: Double) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        let formatted = formatter.string(from: NSNumber(value: value)) ?? "0.00"
        appendLiteral(formatted)
    }
    
    /// 일반 통화 포맷 (소수점 4자리)
    mutating func appendInterpolation(rate value: Double) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 4
        formatter.maximumFractionDigits = 4
        let formatted = formatter.string(from: NSNumber(value: value)) ?? "0.0000"
        appendLiteral(formatted)
    }
}
