//
//  CalculatorViewModel.swift
//  CurrencyConverter
//
//  Created by Milou on 7/10/25.
//

import Foundation

enum CalculatorAction {
    case calculate(String?)
}

struct CalculatorState {
    let exchangeRate: ExchangeRate
    var calculatedResult: String
    var errorMessage: CalculatorError?
    
    init(exchangeRate: ExchangeRate) {
        self.exchangeRate = exchangeRate
        self.calculatedResult = Constants.initialResult
        self.errorMessage = nil
    }
}

final class CalculatorViewModel: ViewModelProtocol {
 
    typealias Action = CalculatorAction
    typealias State = CalculatorState
    
    var action: ((CalculatorAction) -> Void)?
    
    private(set) var state: CalculatorState {
        didSet {
            self.onStateChanged?()
        }
    }

    var onStateChanged: (() -> Void)?
    
    init(exchangeRate: ExchangeRate) {
        self.state = CalculatorState(exchangeRate: exchangeRate)
        self.action = { [weak self] action in
            self?.handleAction(action)
            
        }
    }
    
    private func handleAction(_ action: CalculatorAction) {
        switch action {
        case .calculate(let inputText):
            calculate(with: inputText)
        }
    }
    
    private func calculate(with inputText: String?) {
        state.errorMessage = nil
        
        guard let inputText = inputText, !inputText.isEmpty else {
            handleError(.emptyInput)
            return
        }
        
        guard let input = Double(inputText) else {
            handleError(.invalidInput)
            return
        }
        
        let result = input * state.exchangeRate.rate
        state.calculatedResult = formatResult(input: input, output: result)
    }
    
    private func formatResult(input: Double, output: Double) -> String {
        // "₩1,000 → 0.74 USD" 형태로 표시
        return "₩ \(krw: input) → \(currency: output) \(state.exchangeRate.currency)"
    }
    
    private func handleError(_ error: CalculatorError) {
        state.errorMessage = error
        state.calculatedResult = Constants.initialResult
    }
}
