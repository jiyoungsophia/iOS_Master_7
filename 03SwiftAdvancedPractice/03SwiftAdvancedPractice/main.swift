//
//  main.swift
//  03SwiftAdvancedPractice
//
//  Created by 지영 on 6/4/25.
//

import Foundation

var intArray: [Int] = Array(1...5)
var stringArray: [String] = ["가", "나", "다", "라", "마"]

var introducibleArray : [Introducible] = []
var robot = Robot(name: "Bixby")

// MARK: - 필수 문제 1
print("필수 1-1: \(sum(17, 42))")
calculate(sum)

// MARK: - 필수 문제 2
print("필수 2-1: \(mapIntToString()))")
print("필수 2-2: \(filterEvenNumbersToString())")

let result = myMap(intArray) {
    String($0)
}
print("필수 2-3: \(result))")

// MARK: - 필수 문제 3
print("필수 3-1: \(a(intArray))")
print("필수 3-2: \(b(stringArray))")
print("필수 3-4: \(c(intArray)), \(c(stringArray))")
print("필수 3-5: \(d(intArray))")
//print("필수 3-5: \(d(stringArray))")

// MARK: - 필수 문제 4
testIntroducible()

// MARK: - 필수 문제 5
testDeliverySystem(address: "", status: .inTrasit(daysRemaining: 3))
testDeliverySystem(address: "서울시 마포구", status: .notStarted)
testDeliverySystem(address: "서울시 마포구", status: .error)
testDeliverySystem(address: "서울시 마포구", status: .inTrasit(daysRemaining: 1))

