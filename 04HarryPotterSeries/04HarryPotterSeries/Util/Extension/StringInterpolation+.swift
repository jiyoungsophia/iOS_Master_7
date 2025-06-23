//
//  StringInterpolation+.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/23/25.
//

import Foundation

extension String.StringInterpolation {
    mutating func appendInterpolation(_ date: Date, format: String) {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            let dateString = formatter.string(from: date)
            appendLiteral(dateString)
        }
}
