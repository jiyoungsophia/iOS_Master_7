//
//  DateFormatter+.swift
//  04HarryPotterSeries
//
//  Created by Milou on 6/16/25.
//

import Foundation
//string inteplation
extension DateFormatter {
    static let longDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Calendar.current
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
