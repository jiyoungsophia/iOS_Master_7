//
//  BaseballGame.swift
//  02BaseballGame
//
//  Created by 지영 on 5/26/25.
//

import Foundation


struct BaseballGame {
    func run() {
        print("환영합니다! 원하시는 번호를 입력해주세요")
        
        while true {
            print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
            
            guard let input = readLine(),
                 let number = Int(input) else {
                print("다시 입력해주세요")
                continue
            }
            
            switch number {
            case 1:
                startGame()
            case 2:
                print("2. 게임 기록 보기")
            case 3:
                print("게임을 종료합니다")
                return
            default:
                print("다시 입력해주세요")
            }
        }
    }
    
    func makeAnswer() -> [Int] {
        var answer = Array(0...9).shuffled()
        
        if answer[0] == 0 {
            answer.swapAt(0, Int.random(in: 1...9))
        }
        
        let result = Array(answer.prefix(3))
        
        return result
    }
    
    func startGame() {
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
    
    func validateInput(_ input: String) -> [Int]? {
        guard input.count == 3 else {
            return nil
        }
        
        guard let number = Int(input) else {
            return nil
        }
        
        let numbers = input.compactMap { Int(String($0)) }
        
        guard numbers[0] != 0 else {
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
