//
//  BaseballGameLogic.swift
//  02BaseballGame
//
//  Created by 지영 on 5/28/25.
//

import Foundation

struct BaseballGameLogic: GameLogicInterface {    
  func makeAnswer() -> [Int] {
      var answer = Array(Constants.answerRange).shuffled()
    
      if answer[0] == Constants.forbiddenFirstDigit {
          answer.swapAt(0, Int.random(in: Constants.firstDigitRange))
    }
    
    let result = Array(answer.prefix(Constants.digitCount))
    
    return result
  }
  
  func parseInput(_ input: String) -> [Int]? {
      guard input.count == Constants.digitCount else {
      return nil
    }
    
    guard let number = Int(input) else {
      return nil
    }
    
    let numbers = input.compactMap { Int(String($0)) }
    
    guard numbers[0] != Constants.forbiddenFirstDigit else {
      return nil
    }
    
    return numbers
  }
  
  func getHint(comparing input: [Int], with answer: [Int]) -> String {
    let strikesCount = zip(input, answer)
        .filter { $0 == $1 }
        .count
      
    let ballsCount = zip(input, answer)
        .filter { $0 != $1 && answer.contains($0) }
        .count
    
    switch (strikesCount, ballsCount) {
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
