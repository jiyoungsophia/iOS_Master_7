//
//  CurrencyMapping.swift
//  CurrencyConverter
//
//  Created by Milou on 7/9/25.
//

import Foundation

enum CurrencyMapping {
    private static var cache: [String: String]?
    
    static func getCountryName(for currencyCode: String) -> String {
        if cache == nil {
            cache = loadMapping() 
        }
        return cache?[currencyCode] ?? currencyCode
    }
    
    private static func loadMapping() -> [String: String] {
        guard let path = Bundle.main.path(forResource: "MappingData", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let mapping = try? JSONDecoder().decode([String: String].self, from: data) else {
            return [:]
        }
        return mapping
    }
}
