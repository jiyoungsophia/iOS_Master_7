//
//  main.swift
//  02BaseballGame
//
//  Created by 지영 on 5/26/25.
//

import Foundation

let game = BaseballGame(gameLogic: BaseballGameLogic(), recordManager: RecordManager())
game.run()
