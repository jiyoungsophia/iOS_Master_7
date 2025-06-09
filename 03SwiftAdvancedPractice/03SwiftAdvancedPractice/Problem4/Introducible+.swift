//
//  Introducible+.swift
//  03SwiftAdvancedPractice
//
//  Created by 지영 on 6/9/25.
//

import Foundation

extension Introducible {
    func introduce() -> String {
        return "Hi, my name is \(name)."
    }
}

func testIntroduceExtension() {
    let robot = Robot(name: "Siri🌈")
    let cat = Cat(name: "Nobel😼")
    let dog = Dog(name: "Milou🐶")
    
    print(cat.introduce())
    print(dog.introduce())
    print(robot.introduce())
}
