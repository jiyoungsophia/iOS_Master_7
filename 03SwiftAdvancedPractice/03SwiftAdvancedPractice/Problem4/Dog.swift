//
//  Dog.swift
//  03SwiftAdvancedPractice
//
//  Created by 지영 on 6/5/25.
//

import Foundation

struct Dog: Introducible {
    var name: String
    
    func introduce() -> String {
        return "멍멍🐶, 내 이름은 \(name)."
    }
    
    func goForWalk() -> String {
        return "🦮 \(name)는 산책중"
    }
}
