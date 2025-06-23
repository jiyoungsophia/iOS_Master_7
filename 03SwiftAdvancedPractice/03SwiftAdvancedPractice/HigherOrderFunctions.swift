//
//  HigherOrderFunctions.swift
//  03SwiftAdvancedPractice
//
//  Created by 지영 on 6/5/25.
//

import Foundation

/// check 1
func mapIntToString() -> [String] {
    let numbers = Array(1...5)
    var result = [String]()

    result = numbers.map { String($0) }
    return result
}

/// check 2
func filterEvenNumbersToString() -> [String] {
    let input = Array(1...10)
    var output : Array<String>

    output = input.filter { $0 % 2 == 0 }.compactMap { String($0) }
    return output
}

/// check 3
func myMap(_ array: [Int], _ transform: (Int) -> String) -> [String] {
    var output : [String] = []
    
    for element in array {
        output.append(transform(element))
    }
    return output
}
