//
//  CircularReference.swift
//  03SwiftAdvancedPractice
//
//  Created by 지영 on 6/9/25.
//

import Foundation

class A {
    var name: String
    var classB: B?
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("클래스 A deinit")
    }
}

class B {
    var address: String
    weak var classA: A?
    var closure: (() -> Void)?
    
    init(address: String) {
        self.address = address
    }
    
    deinit {
        print("클래스 B deinit")
    }
}


func testCircularReference() {
    let a = A(name: "Yaeji")
    let b = B(address: "Newyork")
    
    a.classB = b
    b.classA = a
    
    b.closure = {
        print("A 인스턴스 참조해 클로저 기반 순환참조 발생: \(a.name)")
    }
    
    b.closure?()
}

func testWeakReference() {
    let a = A(name: "Yaeji")
    let b = B(address: "Newyork")
    
    a.classB = b // 강한 참조, 해제 안됨
    b.classA = a // 약한 참조
    
    b.closure = { [weak a] in
        guard let a else { return }
        print("클로저 캡처리스트로 순환참조 해결: \(a.name)")
    }
    
    b.closure?()
    a.classB = nil
}
