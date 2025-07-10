//
//  CalculatorViewModel.swift
//  CurrencyConverter
//
//  Created by Milou on 7/10/25.
//

import Foundation

final class CalculatorViewModel {
    let exchangeRate: ExchangeRate
    
    private let initialCalculatedResult = "계산 결과가 여기에 표시됩니다"
    
    private(set) var calculatedResult: String {
        didSet {
            self.onCalculatedResultChanged?()
        }
    }
    
    private(set) var errorMessage: String? = nil {
        didSet {
            if let errorMessage = errorMessage {
                self.onErrorOccurred?(errorMessage)
            }
        }
    }
    
    var onCalculatedResultChanged: (() -> Void)?
    var onErrorOccurred: ((String) -> Void)?
    
    init(exchangeRate: ExchangeRate) {
        self.exchangeRate = exchangeRate
        self.calculatedResult  = initialCalculatedResult
    }
    
    func calculate(with inputText: String?) {
        errorMessage = nil
        
        guard let inputText = inputText, !inputText.isEmpty else {
            errorMessage = "금액을 입력해주세요"
            calculatedResult = initialCalculatedResult
            return
        }
        
        guard let input = Double(inputText) else {
            errorMessage = "올바른 숫자를 입력해주세요"
            calculatedResult = initialCalculatedResult
            return
        }
        
        let result = input * exchangeRate.rate
        
        calculatedResult = formatResult(input: input, output: result)
        
    }
    
    private func formatResult(input: Double, output: Double) -> String {
        // "₩1,000 → 0.74 USD" 형태로 표시
        return "₩ \(krw: input) → \(currency: output) \(exchangeRate.currency)"
    }
}
