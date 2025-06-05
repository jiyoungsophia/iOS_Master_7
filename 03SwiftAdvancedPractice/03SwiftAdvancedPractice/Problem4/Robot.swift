//
//  Robot.swift
//  03SwiftAdvancedPractice
//
//  Created by 지영 on 6/5/25.
//

import Foundation

struct Robot: Introducible {
    var name: String {
        didSet {
            if oldValue != name {
                print("name 변경 알림")
                print("변경 이전 값: \(oldValue)")
                print("변경 후 값: \(name)")
            }
        }
    }
    
    func introduce() -> String {
        return "안녕하세요🤖, 저는 \(name)입니다."
    }
    
    func batteryCharge() -> String {
        return "🦾 배터리 충전 중"
    }
}
