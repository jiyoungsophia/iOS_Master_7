//
//  Helper+Memoize.swift
//  CurrencyConverter
//
//  Created by Milou on 7/9/25.
//

import Foundation

func memoize<T: Hashable, U>(_ f: @escaping (T) -> U) -> (T) -> U {
    var memo: [T: U] = [:]  // "USD": "미국"
    return { input in
        if let result = memo[input] {
            return result
        }
        let result = f(input)
        memo[input] = result
        return result
    }
}
