//
//  Closures.swift
//  03SwiftAdvancedPractice
//
//  Created by 지영 on 6/5/25.
//

import Foundation

let sum: (Int, Int) -> String = {
    return "두 수의 합은 \($0 + $1) 입니다"
}

func calculate(_ sum: (Int, Int) -> String) -> Void {
    print("필수 1-2: \(sum(17, 47))")
}
