//
//  BaseballGame.swift
//  02BaseballGame
//
//  Created by 지영 on 5/26/25.
//

import Foundation


struct BaseballGame {
    private let gameLogic = BaseballGameLogic()
    private let recordManager = RecordManager()
    
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
                recordManager.showRecords()
            case 3:
                print("게임을 종료합니다")
                return
            default:
                print("다시 입력해주세요")
            }
        }
    }
    
    func startGame() {
        let answer = gameLogic.makeAnswer()
        var attemptCount = 0
        
        print("< 게임을 시작합니다 >")
        
        while true {
            print("숫자를 입력하세요")
            attemptCount += 1
            
            guard let input = readLine() else {
                print("올바르지 않은 입력값입니다")
                continue
            }
            
            guard let numbers = gameLogic.validateInput(input) else {
                print("올바르지 않은 입력값입니다")
                continue
            }
            
            if numbers == answer {
                print("정답입니다!")
                recordManager.addRecord(attempts: attemptCount)
                break
            }
            
            let hint = gameLogic.getHint(comparing: numbers, with: answer)
            print(hint)
        }
    }
}
