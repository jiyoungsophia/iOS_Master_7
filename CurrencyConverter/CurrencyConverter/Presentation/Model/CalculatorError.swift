//
//  CalculatorError.swift
//  CurrencyConverter
//
//  Created by Milou on 7/10/25.
//

import Foundation

enum CalculatorError: Error {
    case emptyInput
    case invalidInput
    
    var localizedDescription: String {
        switch self {
        case .emptyInput:
            return "금액을 입력해주세요"
        case .invalidInput:
            return "올바른 숫자를 입력해주세요"
        }
    }
}
