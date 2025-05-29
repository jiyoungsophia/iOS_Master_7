//
//  GameLogicInterface.swift
//  02BaseballGame
//
//  Created by 지영 on 5/29/25.
//

import Foundation

protocol GameLogicInterface {
    func makeAnswer() -> [Int]
    func validateInput(_ input: String) -> [Int]?
    func getHint(comparing input: [Int], with answer: [Int]) -> String
}
