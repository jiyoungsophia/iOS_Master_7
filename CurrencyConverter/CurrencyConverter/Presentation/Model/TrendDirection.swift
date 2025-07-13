//
//  TrendDirection.swift
//  CurrencyConverter
//
//  Created by Milou on 7/13/25.
//

import Foundation

enum TrendDirection: String, CaseIterable {
    case up = "up"
    case down = "down"
    case none = "none"
    
    var icon: String {
        switch self {
        case .up:
            return "🔼"
        case .down:
            return "🔽"
        case .none:
            return ""
        }
    }
}
