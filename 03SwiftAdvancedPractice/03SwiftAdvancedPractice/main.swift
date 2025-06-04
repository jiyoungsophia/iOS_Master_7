//
//  main.swift
//  03SwiftAdvancedPractice
//
//  Created by 지영 on 6/4/25.
//

import Foundation


// MARK: - 필수 문제 1
let sum: (Int, Int) -> String = {
    return "두 수의 합은 \($0 + $1) 입니다"
}

print(sum(17, 42))

func calculate(_ sum: (Int, Int) -> String) -> Void {
    print(sum(17, 47))
}

calculate(sum)


// MARK: - 필수 문제 2



// MARK: - 필수 문제 3
