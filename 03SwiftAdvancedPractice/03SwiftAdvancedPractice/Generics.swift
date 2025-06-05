//
//  Generics.swift
//  03SwiftAdvancedPractice
//
//  Created by 지영 on 6/5/25.
//

import Foundation

/// check 1
func a(_ input: [Int]) -> [Int] {
    return input.enumerated()
        .filter { $0.offset % 2 == 0 }
        .map { $0.element }
}

/// check 2
func b(_ input: [String]) -> [String] {
    return input.enumerated()
        .filter { $0.offset % 2 == 0 }
        .map { $0.element }
}

/// check 3, 4
func c<T>(_ input: [T]) -> [T] {
    return input.enumerated()
        .filter { $0.offset % 2 == 0 }
        .map { $0.element }
}

/// check 5
func d<T>(_ input: [T]) -> [T] where T: Numeric {
    return input.enumerated()
        .filter { $0.offset % 2 == 0 }
        .map { $0.element }
}
