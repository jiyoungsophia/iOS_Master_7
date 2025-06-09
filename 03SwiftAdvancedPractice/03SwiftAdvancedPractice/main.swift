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

var hybrid = HybridCar(brand: "iOS", model: "마스터", year: "2025", engine: .electric)

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

// MARK: - 도전 문제 1
/*
 1. 상속
 - 장점: 부모 클래스에서 선언된 프로퍼티 공유, 메서드 자동으로 사용가능
 - 단점: 하나만 상속 가능하고 struct, enum에서는 상속 불가, 부모 클래스 변경시 모든 자식 클래스에 영향
 
 2. 프로토콜
 - 장점: 여러 프로토콜을 동시에 채택가능하고 class, struct, enum 모두 채택 가능, 구현체와 인터페이스 분리
 - 단점: 프로토콜의 요구사항 구현해야 하고, 저장 프로퍼티 공유 안됨
 */
hybrid.switchEngine(to: .hydrogen)

// MARK: - 도전 문제 2
testSortableBox()
