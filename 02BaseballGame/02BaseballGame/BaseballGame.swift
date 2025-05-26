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
        print("< 게임을 시작합니다 >")
        
        while true {
            print("숫자를 입력하세요")
            
            guard let input = readLine() else {
                print("올바르지 않은 입력값입니다")
                continue
            }
            
            guard let numbers = validateInput(input) else {
                print("올바르지 않은 입력값입니다")
                continue
            }
            
            if numbers == answer {
                print("정답입니다!")
                break
            }
            
            let hint = getHint(comparing: numbers, with: answer)
            print(hint)
        }
    }
    
    func makeAnswer() -> [Int] {
        var numbers: Set<Int> = []
        while numbers.count < 3 {
            numbers.insert(Int.random(in: 1...9))
        }
        
        return Array(numbers)
    }
    
    func validateInput(_ input: String) -> [Int]? { // enum switch문 처리하면 과할까?
        guard input.count == 3 else {
            return nil
        }
        
        guard let number = Int(input) else {
            return nil
        }
        
        let numbers = input.compactMap { Int(String($0)) }
        
        guard !numbers.contains(0) else {
            return nil
        }
        
        return numbers
    }
    
    func getHint(comparing input: [Int], with answer: [Int]) -> String {
        var strikesCount = 0
        var ballCount = 0

        for index in 0..<3 {
            if input[index] == answer[index] {
                strikesCount += 1
            }
        }
        
        for index in 0..<3 {
            if input[index] != answer[index] && answer.contains(input[index]) {
                ballCount += 1
            }
        }
        
        switch (strikesCount, ballCount) {
        case (0, 0):
            return "Nothing!"
        case (let strikes, 0) where strikes > 0:
            return "\(strikes) 스트라이크"
        case (0, let balls) where balls > 0:
            return "\(balls) 볼"
        case (let strikes, let balls) where strikes > 0 && balls > 0:
            return "\(strikes) 스트라이크, \(balls) 볼"
        default:
            return "Nothing!"
        }
    }
    
    
}
