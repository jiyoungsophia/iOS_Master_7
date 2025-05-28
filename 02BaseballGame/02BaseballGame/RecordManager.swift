//
//  RecordManager.swift
//  02BaseballGame
//
//  Created by 지영 on 5/28/25.
//

import Foundation

class RecordManager {
    private var records: [Int] = []
    
    func addRecord(attempts: Int) {
        records.append(attempts)
    }
    
    func showRecords() {
        if records.isEmpty {
            print("기록이 없습니다")
            return
        }
        
        records.enumerated().forEach { index, attemptCount in
            print("\(index + 1)번째 게임: 시도 횟수 - \(attemptCount)")
        }
    }
}
