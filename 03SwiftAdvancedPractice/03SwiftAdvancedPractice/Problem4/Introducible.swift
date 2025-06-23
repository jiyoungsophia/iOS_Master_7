//
//  Introducible.swift
//  03SwiftAdvancedPractice
//
//  Created by 지영 on 6/5/25.
//

import Foundation

protocol Introducible {
    var name: String { get }
    func introduce() -> String
}

func testIntroducible() {
    var introducibleArray : [Introducible] = []
    var robot = Robot(name: "Bixby")
    
    robot.name = "Siri"
    
    introducibleArray.append(robot)
    introducibleArray.append(Cat(name: "Nobel"))
    introducibleArray.append(Dog(name: "Milou"))

    for item in introducibleArray {
        if let robot = item as? Robot {
            print(robot.batteryCharge())
        }
        else if let cat = item as? Cat {
            print(cat.makeSound())
        }
        else if let dog = item as? Dog {
            print(dog.goForWalk())
        }
    }
}
