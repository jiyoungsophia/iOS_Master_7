//
//  BaseballGame.swift
//  02BaseballGame
//
//  Created by 지영 on 5/26/25.
//

import Foundation

struct BaseballGame {
    private let gameLogic: GameLogicInterface
    private let recordManager: RecordManagingInterface
    
    init(gameLogic: GameLogicInterface, recordManager: RecordManagingInterface) {
        self.gameLogic = gameLogic
        self.recordManager = recordManager
    }
    
    func run() {
        print(Constants.Messages.welcomeGreeting)
        
        while true {
            print(Constants.Messages.menuOptions)
            
            guard let input = readLine(),
                  let number = Int(input) else {
                print(Constants.Messages.retryInput)
                continue
            }
            
            switch number {
            case Constants.Menus.startGame:
                startGame()
            case Constants.Menus.showRecords:
                recordManager.showRecords()
            case Constants.Menus.exitGame:
                print(Constants.Messages.gameEnd)
                return
            default:
                print(Constants.Messages.invalidMenuNumber)
            }
        }
    }
    
    func startGame() {
        let answer = gameLogic.makeAnswer()
        var attemptCount = 0
        
        print(Constants.Messages.gameStart)
        
        while true {
            print(Constants.Messages.inputPrompt)
            attemptCount += 1
            
            guard let input = readLine() else {
                print(Constants.Messages.invalidInput)
                continue
            }
            
            guard let numbers = gameLogic.parseInput(input) else {
                print(Constants.Messages.invalidInput)
                continue
            }
            
            if numbers == answer {
                print(Constants.Messages.correctAnswer)
                recordManager.addRecord(attempts: attemptCount)
                break
            }
            
            let hint = gameLogic.getHint(comparing: numbers, with: answer)
            print(hint)
        }
    }
}
