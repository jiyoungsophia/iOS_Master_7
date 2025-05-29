//
//  Constants.swift
//  02BaseballGame
//
//  Created by 지영 on 5/29/25.
//

import Foundation

struct Constants {
    
    static let digitCount = 3
    static let answerRange = 0...9
    static let firstDigitRange = 1...9
    static let forbiddenFirstDigit = 0
    
    // MARK: - 메뉴 번호들 (BaseballGame.swift에서)
    struct Menus {
        static let startGame = 1                     // case 1:
        static let showRecords = 2                   // case 2:
        static let exitGame = 3                      // case 3:
    }
    
    // MARK: - 모든 출력 메시지들
    struct Messages {
        
        // BaseballGame.swift의 메시지들
        static let welcomeGreeting = "환영합니다! 원하시는 번호를 입력해주세요"
        static let menuOptions = "1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기"
        static let retryInput = "다시 입력해주세요"
        static let invalidMenuNumber = "올바른 숫자를 입력해주세요!"
        static let gameEnd = "< 숫자 야구 게임을 종료합니다 >"
        static let gameStart = "< 게임을 시작합니다 >"
        static let inputPrompt = "숫자를 입력하세요"
        static let invalidInput = "올바르지 않은 입력값입니다"
        static let correctAnswer = "정답입니다!"
        
        // BaseballGameLogic.swift의 힌트 메시지들
        static let nothingHint = "Nothing!"
        static let strikeText = "스트라이크"
        static let ballText = "볼"
        
        // RecordManager.swift의 메시지들
        static let noRecords = "기록이 없습니다"
        static let gameRecordFormat = "번째 게임: 시도 횟수 - "     // "\(index + 1)번째 게임: 시도 횟수 - \(attemptCount)"
    }
}
