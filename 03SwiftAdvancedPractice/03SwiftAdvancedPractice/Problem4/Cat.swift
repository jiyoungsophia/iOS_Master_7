//
//  Cat.swift
//  03SwiftAdvancedPractice
//
//  Created by 지영 on 6/5/25.
//

import Foundation

struct Cat: Introducible {
    var name: String
    
    func introduce() -> String {
        return "야옹😺, 내 이름은 \(name)."
    }
    
    func makeSound() -> String {
        return "🐈 Meow"
    }
}
