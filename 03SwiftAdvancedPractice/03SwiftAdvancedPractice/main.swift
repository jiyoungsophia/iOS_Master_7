//
//  main.swift
//  03SwiftAdvancedPractice
//
//  Created by 지영 on 6/4/25.
//

import Foundation


// MARK: - 필수 문제 1
print("=== 필수 문제 1 ===")
let sum: (Int, Int) -> String = {
    return "두 수의 합은 \($0 + $1) 입니다"
}

print("필수 1-1: \(sum(17, 42))")

func calculate(_ sum: (Int, Int) -> String) -> Void {
    print("필수 1-2: \(sum(17, 47))")
}

calculate(sum)



// MARK: - 필수 문제 2
print("=== 필수 문제 2 ===")
/// check 1
let numbers = Array(1...5)
var result = [String]()

result = numbers.map { String($0) }
print("필수 2-1: \(result))")


/// check 2
let input = Array(1...10)
var output : Array<String>

output = input.filter { $0 % 2 == 0 }.compactMap { String($0) }
print("필수 2-2: \(output))")


/// check 3
func myMap(_ array: [Int], _ transform: (Int) -> String) -> [String] {
    var output : [String] = []
    
    for element in array {
        output.append(transform(element))
    }
    return output
}

let result1 = myMap([1, 2, 3, 4, 5]) {
    String($0)
}

print("필수 2-3: \(result1))")



// MARK: - 필수 문제 3
print("=== 필수 문제 3 ===")
/// check 1
func a(_ input: [Int]) -> [Int] {
    return input.enumerated()
        .filter { $0.offset % 2 == 0 }
        .map { $0.element }
}

print("필수 3-1: \(a(Array(1...5)))")

/// check 2
func b(_ input: [String]) -> [String] {
    return input.enumerated()
        .filter { $0.offset % 2 == 0 }
        .map { $0.element }
}

print("필수 3-2: \(b(["가", "나", "다", "라", "마"]))")

/// check 3, 4
func c<T>(_ input: [T]) -> [T] {
    return input.enumerated()
        .filter { $0.offset % 2 == 0 }
        .map { $0.element }
}

print("필수 3-3: \(c(Array(1...5))), \(c(["가", "나", "다", "라", "마"]))" )

/// check 5
func d<T>(_ input: [T]) -> [T] where T: Numeric {
    return input.enumerated()
        .filter { $0.offset % 2 == 0 }
        .map { $0.element }
}
