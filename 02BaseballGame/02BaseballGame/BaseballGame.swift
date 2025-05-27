//
//  BaseballGame.swift
//  02BaseballGame
//
//  Created by 지영 on 5/26/25.
//

import Foundation


struct BaseballGame {
    func start() {
        let answer = makeAnswer()
        print(answer)
    }
    
    func makeAnswer() -> Int {
        var numbers: Set<Int> = []
        while numbers.count < 3 {
            numbers.insert(Int.random(in: 1...9))
        }
        
        var result = 0
        for number in numbers {
            result = result * 10 + number
        }
        return result
    }
}
