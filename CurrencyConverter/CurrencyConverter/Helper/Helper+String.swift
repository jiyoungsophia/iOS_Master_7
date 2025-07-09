//
//  Helper+String.swift
//  CurrencyConverter
//
//  Created by Milou on 7/9/25.
//

import Foundation

extension String  {
    var toCountryName: String {
        return CurrencyMapping.getCountryName(from: self)
    }
}
