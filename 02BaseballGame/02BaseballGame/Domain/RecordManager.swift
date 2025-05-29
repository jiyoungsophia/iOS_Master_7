//
//  RecordManager.swift
//  02BaseballGame
//
//  Created by 지영 on 5/28/25.
//

import Foundation

class RecordManager: RecordManagingInterface {
    private var records: [Int] = []
    
    func addRecord(attempts: Int) {
        records.append(attempts)
    }
    
    func showRecords() {
        if records.isEmpty {
            print(Constants.Messages.noRecords)
            return
        }
        
        records.enumerated().forEach { index, attemptCount in
            print("\(index + 1)\(Constants.Messages.gameRecordFormat)\(attemptCount)")
        }
    }
}
