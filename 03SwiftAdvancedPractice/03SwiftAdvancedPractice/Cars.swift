//
//  Cars.swift
//  03SwiftAdvancedPractice
//
//  Created by 지영 on 6/5/25.
//

import Foundation

/// 상속을 사용해 기능을 추가하는 것과 프로토콜 채택을 통해 기능을 추가하는 것
/// 각각 장단점, 차이
///
///

enum Engine {
    case electric
    case hydrogen
}

class Car {
    private let brand: String
    private let model: String
    private let year: String
    var engine: Engine {
        didSet {
            print("\(engine)으로 엔진 변경")
        }
    }
    
    init(brand: String, model: String, year: String, engine: Engine) {
        self.brand = brand
        self.model = model
        self.year = year
        self.engine = engine
    }
    
    public func drive() {
        print("\(year) \(brand) \(model) - \(engine) 엔진 차 주행 중...🚙🚗")
    }
    
    public func stop()  {
        print("차 멈춤")
    }
}

class ElectricCar: Car {
    override init(brand: String, model: String, year: String, engine: Engine) {
        super.init(brand: brand, model: model, year: year, engine: .electric)
    }
}

class hybridCar: Car {
    override init(brand: String, model: String, year: String, engine: Engine) {
        super.init(brand: brand, model: model, year: year, engine: engine)
    }
    
    public func switchEngine(to newEngine: Engine) {
        self.engine = newEngine
    }
}
